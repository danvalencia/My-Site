# Closures and scoping

Per Wikipedia, a Closure is:

	> ... a function or reference to a function together with a referencing environment—a table storing a reference to each of the non-local variables (also called free variables) of that function.

I want you to pay special attention to the last part of that definition: _together with a referencing environment, containing references to each of the non-local variables of that function_.  More on this later.

As I was pair programming with my coworker, we ran into an issue which led us to a deeper understanding of how Javascript handles closures . The task at hand was a mini library for managing analytics events for a HTML5 mobile app.  Each analytics event could have 1 or more _attributes_ associated with it and are triggered by _'click'_ events on different DOM elements within the page.  For example, one of the events is called _modelTap_; here is a example, in JSON format, of the attributes that this event may be associated with:

	{
		'navigationCategory' : 'popular',
		'model' : 'myModel'
	}

The tricky part is that, different events may contain different type of attributes, and these attributes need to be populated from different parts of the DOM, and in different ways.  We solved this is by creating an _array_ of configuration objects that define the following properties:

- _eventName_, a _String_, 
- a css _selector_, a _String_, 
- and a _getAttributes_  _Function_ that returns a Javascript object that can be easily serialized to JSON format.

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
				var tabMane = $(context).text();
				return {tabName: tabName};
			}
		}
	];
	

The idea was to iterate through the configuration array and for each config object attach a _'click'_ event handler to the elements resolved by the _selector_ property.  Within the _click_ handler, we would call a function that would be responsible of resolving the event name and the attributes to send to the analytics API.

In other words :) :

	for (var i = 0; i < analyticConfigs.length; i++) {
		var config = analyticConfigs[i];
		$(body).on('click', config.selector, function() {
			sendAnalyticsEvent(this, config);
		})
	}

	function sendAnalyticsEvent(context, config) {
		var eventName = config.eventName;
		var attributes = config.getAttributes(context);

		AnalyticsAPI.sendEvent(eventName, attributes);
	}

This should work fine, right ? 

Not so fast, buddy. 

Can you guess where the problem is ?

The problem lies in the for loop:

	for (var i = 0; i < analyticConfigs.length; i++) {
		var config = analyticConfigs[i];
		$(body).on('click', config.selector, function() {
			sendAnalyticsEvent(this, config);
		})
	}

Turns out, Javascript does not create a new scope withing each iteration, hence the _config_ var does not get re-allocated, causing that each _click_  event handler contains the reference to the same _config_ object.  


The _AnalyticsAPI_ object contains all the fun analytics integration code, and it's not relevant to this discussion.



	
	FOR