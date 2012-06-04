require 'test_helper'
require 'mysite/image_service'

class ImageServiceTest < ActiveSupport::TestCase
    
  def setup
    @image_service = Mysite::ImageService.new do |c|
      c.image_service_key = Rails.application.config.image_service[:key]
      c.image_service_key_private = Rails.application.config.image_service[:key_private]
      c.image_service_site = Rails.application.config.image_service[:site]
      c.username = Rails.application.config.image_service[:username] || '_DanValencia'
      c.password = Rails.application.config.image_service[:password] || 'backh0ff1'
    end
    
    assert_not_nil @image_service
    
  end
    
  def test_can_login
    #access_token = @image_service.login
    
    #assert_not_nil access_token
  end

end
