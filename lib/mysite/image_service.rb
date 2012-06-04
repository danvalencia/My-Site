require 'oauth'
require 'oauth/consumer'
require 'json'
require 'mysite/with_rails_logger'

#patch to override api.photobucket.com in SBS
module OAuth::RequestProxy
    class Base
        def normalized_uri
            u = URI.parse(uri)
            "#{u.scheme.downcase}://api.photobucket.com#{(u.scheme.downcase == 'http' && u.port != 80) || (u.scheme.downcase == 'https' && u.port != 443) ? ":#{u.port}" : ""}#{(u.path && u.path != '') ? u.path : '/'}"
        end
    end
end

module OAuth::Signature::HMAC
    class Base < OAuth::Signature::Base

        private

        def digest
            puts ">>> " + signature_base_string
            self.class.digest_class Object.module_eval("::Digest::#{self.class.digest_klass}")
            sig = Digest::HMAC.digest(signature_base_string, secret, self.class.digest_class)
            puts ">>>>>> " + Base64.encode64(sig).chomp.gsub(/\n/,'')
            sig
        end
    end
end

module Mysite
  
  class ImageService
    include WithRailsLogger

    REQUEST_TOKEN_PATH = '/login/request'
    AUTHORIZE_PATH = '/apilogin/login',
    ACCESS_TOKEN_PATH = '/login/access'
    
    attr_accessor :image_service_key, :image_service_key_private, :image_service_site, :username, :password
     
    def initialize(&block)
      block.call(self) unless block.nil?
    end
    
    def login
      @consumer = OAuth::Consumer.new( image_service_key,
                                       image_service_key_private,
                                       { :site => image_service_site,
                                         :scheme => :header,
                                         :request_token_path => REQUEST_TOKEN_PATH,
                                         :authorize_path => AUTHORIZE_PATH,
                                         :access_token_path => ACCESS_TOKEN_PATH
                                       })
      
      #set up an empty access token because its easier
      @access = OAuth::AccessToken.new(@consumer, '', '')
      #@access = @consumer.get_request_token
      
      logger.debug "Access token: #{@access}"
      
      #do a login direct
      response_str = @access.post("/login/direct/" + username, {:password => password })
     
      logger.debug "Response Body: #{response_str.body}"
      
      response_body = JSON.parse(response_str.body)
      
      if response_body["status"] == "Exception" 
        log.error "Could not login because of error: #{response_body['message']}" 
        return
      end
      
      logger.debug "Json parsed response: #{response_body}"
      
      #todo catch errors here before parsing content, probably
      @subdomain = accessresp['subdomain']
      #pull out stuff from response
      @access.token = @accessresp['oauth_token']
      @access.secret = @accessresp['oauth_token_secret']
      @username = @accessresp['username']
      #reset the consumer url (yes, do it like this - must set site and url() resets the internal http object
      reset_url
    end
    
    def upload_image
      #upload a url to the album
      @resp = @access.post("/album/" + OAuth::Helper::escape(username + '/rubytest1') + '/upload', 
                           {:format=>"json", :type=>'url', :imageUrl=>'http://www.google.com/intl/en_ALL/images/logo.gif'})
      print JSON.parse(@resp.body).to_yaml
      
    end
    
    private
    
    def reset_url
      @consumer.options[:site] = "http://#{@subdomain}"
      @consumer.uri("http://#{@subdomain}")      
    end
    
  end
end