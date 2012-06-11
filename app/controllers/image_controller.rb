require 'mysite/image_service'

class ImageController < ApplicationController
  def new
  end

  def upload
  	image = params[:image]
  	logger.debug "Params: #{params}"
  	image_service = get_image_service
  	@debug_text = "Image object: #{image}"
  	#@debug_text = "Image tempfile path: #{image.tempfile}, Image name: #{image.original_filename}"
  	logger.debug @debug_text
  	@image_url = image_service.upload(image.tempfile.path, image.original_filename)
  	render :json => {url: @image_url}
  end

  private

  def get_image_service
  	Mysite::ImageService.new( Rails.application.config.image_service[:key],
        					  Rails.application.config.image_service[:key_secret])    
  end
end
