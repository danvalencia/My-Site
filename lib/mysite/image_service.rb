require 'mysite/with_rails_logger'
require 'aws/s3'

module Mysite
  
  class ImageService
    include WithRailsLogger
    
    SERVER_PREFIX = "http://s3.amazonaws.com"
    BUCKET_NAME = "danvalencia_my_site"
    
    attr_accessor :access_key_id, :secret_access_key
     
    # def initialize(&block)
    #   block.call(self) unless block.nil?
    # end

    def initialize(key_id, key_secret)
      @access_key_id = key_id
      @secret_access_key = key_secret
    end
    
    def upload(file_path, file_name, bucket_name="danvalencia_my_site")
      AWS.config({
        :access_key_id => access_key_id,
        :secret_access_key => secret_access_key,
      })
      
      file_name.gsub!(/ /, '_')
      
      s3 = AWS::S3.new

      buckets = s3.buckets
      my_bucket = buckets[BUCKET_NAME]
      logger.debug "My Bucket: #{my_bucket}"
      
      # upload a file
      #basename = File.basename(file_path)

      o = my_bucket.objects[file_name]
      o.write(:file => file_path, :acl => :public_read)
      
      image_url = "#{SERVER_PREFIX}/#{BUCKET_NAME}/#{file_name}"
      
      logger.debug "File: #{file_name} written to S3.  Url: #{image_url}"
      
      #o.url_for(:read, :secure => false).to_s
      image_url
    end
        
  end
end