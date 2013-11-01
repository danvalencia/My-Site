# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

converter = new Markdown.Converter()
editor = new Markdown.Editor(converter)

dialog_options = 
	width: '500px'
	resizable: false
	autoOpen: false
	open: (event, ui) -> 
		$(".ui-dialog-titlebar-close").hide()

$dialog = $("#dialog").dialog(dialog_options).unbind  "dialogclose" 			    		
$imageUrl = $("#image_url")
$uploadButton = $("#upload_btn")
$imageLoader = $("#upload-image-loader")

editor.hooks.set "insertImageDialog", (callback) =>

	insertImage = => 
		callback($imageUrl.val())
		closeDialog()

	closeDialog = =>
		$imageUrl.val("")
		$dialog.dialog "close"

	$("#insert_image_btn").click (a,b,c) => 
		insertImage()	

	$dialog.dialog().bind "dialogclose", (event, ui) =>
		closeDialog()
		callback(null)
	
	$uploadButton.click ->
		$imageLoader.show()
		formData = new FormData()
		file_name = $('#image')[0].files[0]
		formData.append "image", file_name
		$.ajax '/image/upload',
			type: 'POST'
			data: formData
			cache: false
			contentType: false
			processData: false
			success: (data, text_status, xml_http_request) ->
				$dialog.dialog().unbind "dialogclose"
				$imageUrl.val data.url
				$imageLoader.hide()
			error: (xml_http_request, text_status, error) ->
				closeDialog()
				$imageLoader.hide()

		$imageLoader.show()

	$dialog.dialog('open')
	
	return true

editor.run()

# progressHandlingFunction(e) ->
#     if(e.lengthComputable)
#         $('progress').attr {value:e.loaded,max:e.total}


		
 #        editor.run();
	# 	editor.hooks.set("insertImageDialog", function (callback) {
	# 		$(document).ready(function(){
	# 			$("#insert_image_btn").click(function(a,b,c){
	# 				callback($("#image_url").val());
	# 				$("#dialog").dialog("close");
	# 			})		
				
	# 			$("#dialog").dialog({width: '500px', resizable: false}).unbind( "dialogclose");			    		
	# 		    $("#dialog").dialog().bind( "dialogclose", function(event, ui) {
	# 			  callback(null);
	# 			});
				
	# 			$("#upload_btn").click(function(){
	# 				$("#upload-image-loader").show();
	# 				var formData = new FormData();
	# 				formData.append('image', $('#image')[0].files[0])
	# 			    $.ajax({
	# 			        url: '/image/upload',  //server script to process data
	# 			        type: 'POST',
	# 			        success: function(responseText,b,c){
	# 						$("#dialog").dialog().unbind( "dialogclose");
	# 						$("#image_url").val(responseText.url);
	# 						$("#upload-image-loader").hide();
	# 					},
	# 			        error: function(responseText, b,c){
	# 						callback(null);
	# 						$("#dialog").close();
	# 						$("#upload-image-loader").hide();
	# 					},
	# 			        // Form data
	# 			        data: formData,
	# 			        //Options to tell JQuery not to process data or worry about content-type
	# 			        cache: false,
	# 			        contentType: false,
	# 			        processData: false
	# 			    });
	# 				$("#upload-image-loader").show();
	# 			})
	# 		});
			
	# 		return true;
	# 	});
		
 #        editor.run();
	# })();
	
	# function progressHandlingFunction(e){
	#     if(e.lengthComputable){
	#         $('progress').attr({value:e.loaded,max:e.total});
	#     }
	# }
