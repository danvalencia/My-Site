require 'test_helper'
require 'mysite/image_service'

class ImageServiceTest < ActiveSupport::TestCase
    
  def setup
    @image_service = Mysite::ImageService.new (
        Rails.application.config.image_service[:key],
        Rails.application.config.image_service[:key_private])    
    assert_not_nil @image_service
    
  end
    
end
