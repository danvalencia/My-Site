Per Wikipedia, a Closure is:

> ... a function or reference to a function together with a referencing environment—a table storing a reference to each of the non-local variables (also called free variables) of that function.

I want you to pay special attention to the last part of that definition: **_together with a referencing environment, containing references to each of the non-local variables of that function_**.  This is easier explained with a little code:

     function closureTest() {
          var outerVar = "World";
          document.onload = function() {
               console.log("Hello" + outerVar);
          }
     }

In this example, the _referencing environment_ corresponds to the _outerVar_ variable, and the closure is the function that's assigned to the _document.onload_ event property.   The result of this example is a "Hello World" message printed in the console when the document is loaded.  

You might not be impressed by any of this, as this is a pretty trivial example.  The interesting thing to understand about closures lies not so much in the ability to treat functions as variables, but rather in the context (or _referencing environment_) that these functions can _reference_ in a future point in time.

### A True Story about Closures 

The other day, as I was pair programming with my coworker, we ran into an issue which led us to a deeper understanding of how Javascript handles closures . The task at hand was a mini library for managing analytics events for a _HTML5_ mobile app.  Each analytics event is triggered by a DOM event (e.g. _click_) and can have 1 or more _attributes_ associated with it.  For example, these are the attributes associated with the _modelTap_ event:

	{
		'navigationCategory' : 'popular',
		'model' : 'myModel'
	}

Simple stuff.  The tricky part is that, different _events_ may contain different type of _attributes_, and these _attributes_ need to be populated from different parts of the DOM.  We solved this is by creating an _array_ of analytic configuration objects, containing the following properties:

- **_eventName_**, a _String_, 
- a CSS **_selector_**, a _String_, 
- and a **_getAttributes_**  _Function_ that returns a Javascript object with the attributes for this event.

For example:
	
	var analyticConfigs = [
		{
			eventName: 'modelTap',
			selector: 'li.model',
			getAttributes: function(context) {
				var model = $(context).text();
				var navigationCategory = $(context).find('#category').text();
				return {model: model, navigationCategory: navigationCategory};
			}
		},
		{
			eventName: 'navTap',
			selector: 'li.navigation_tab',
			getAttributes: function(context) {
				var tabName = $(context).text();
				return {tabName: tabName};
			}
		}
	];
	

The idea is to iterate through the configuration array and for each config object attach a _'click'_ event handler to the elements resolved by the _selector_ property.  Within the _click_ handler, we would call the function that's responsible for resolving the _event name_ and  
_attributes_ object and send this info through the analytics API.

To put it in code:

	for (var i = 0; i < analyticConfigs.length; i++) {
		var config = analyticConfigs[i];
		$('body').on('click', config.selector, function() {
			sendAnalyticsEvent(this, config);
		})
	}

	function sendAnalyticsEvent(context, config) {
		var eventName = config.eventName;
		var attributes = config.getAttributes(context);

                // Omitting API call to analytics code for clarity.
		console.log("Sending analytic event: " + eventName + "; with attributes " + JSON.stringify(attributes)); 
	}

This should work fine, right ? Turns out it doesn't.  After doing a couple of clicks to the different elements, the output of this is:

     > Sending analytic event: navTap; with attributes {"tabName":"Super Tab"}
     > Sending analytic event: navTap; with attributes {"tabName":"Super Tab"}

Can you guess where the problem is ?

The problem lies in the for loop.  Turns out, Javascript creates new scopes within _functions_ (i.e. private variables), however, it does not do so within blocks (i.e. _for_ and _while_ loops).  This means that there's a single _config_ var created for the entire duration of the loop (and beyond!), and that every _closure_ created within the loop, will reference the same _config_ object. 

To make this clearer, we can print the contents of the _config_ object outside the loop:

     for (var i = 0; i < analyticConfigs.length; i++) {
          var config = analyticConfigs[i];
          $('body').on('click', config.selector, function() {
               sendAnalyticsEvent(this, config);
          })
     }  
     console.log("Config: " + config.eventName);
    
The code above prints:

     > Config: navTap

Sick, right ?

### So, how to solve this?

The key is to create a new scope for the _config_ variable.  As I mentioned previously, Javascript creates a new scope each time a function is created, so we can leverage this in the following way:

     for (var i = 0; i < analyticConfigs.length; i++) {
          var config = analyticConfigs[i];
          $('body').on('click', config.selector, function(cfg) {
                return function() { sendAnalyticsEvent(this, cfg) };
          }(config));
     }  

What we're doing here is wrapping our function within an anonymous function that receives a _cfg_ parameter, effectively creating a new scope (where the _cfg_ var lives in).  We immediately call this function passing in our _config_ variable.

The output of this code is now:

     > Sending analytic event: modelTap; with attributes {"model":" Super Model ","navigationCategory":""}
     > Sending analytic event: navTap; with attributes {"tabName":" Super Tab "}  

Interesting, right ?

### Conclusion

Lots of languages have closures: obviously functional languages such as Scala, Haskell, Clojure, etc, but also Object Oriented languages such as Ruby, Python, and C#.  Even in Java you can achieve similar functionality with anonymous inner classes.  In all of these languages though, new scopes are created within blocks such as _for_ and _while_ loops.  

Take as an example the following Ruby code:

     closure_array = []
     numbers = %w{one two three}

     numbers.each do |n|
       closure_array << ->{puts n}
     end

     closure_array.each do |c|
       c.call
     end

The output of the above code is:

     > one
     > two
     > three

As you can see, things work as expected, and there's no need to create a new scope to make things work as expected. 
  
Javascript is a very powerful language, that's far from perfect.  In my opinion, this is a flaw in the language itself.  Of course, you can argue that it's just a matter of understanding the language, but still you have to accept that it's counter intuitive.  This is just one example of why languages such as _CoffeeScript_ have emerged.  All in all, I enjoy programming in Javascript a lot, and the more I understand it, the more I enjoy it.

As Douglas Crockford put it, _Javascript_ is [the worlds most misunderstood language.][1]


  [1]: http://www.crockford.com/javascript/javascript.html