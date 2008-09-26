require 'rubygems'
require 'xmpp4r-simple'
require 'httparty'

module Whassap
  
  class RestClient
    include HTTParty
    base_uri 'localhost:3000'
    format :xml
    
    attr_accessor :user
    
    def run
      @user = 'brian'
      start_status_sending_thread
      listen
    end
    
    #######
    private
    #######
    
    def start_status_sending_thread
      Thread.new do
        loop do
          new_whassap_status = gets.chomp
          next unless new_whassap_status
          
          self.class.post("/users/#{user}/statuses.xml", 
            :query => {:status => {:body => new_whassap_status}})
        end
      end.run
    end
    
    def listen
      loop do         
        statuses = self.class.get("/users/#{user}/statuses")['statuses']
        if statuses.empty?
          puts "(no status)"
        else
          puts format_status(statuses.first)
        end
        puts
        sleep 10
      end
    end
    
    def format_status(status)
      "[#{status['created_at'].to_s(:short)}] #{status['body']}"        
    end
    
  end
  
end

Whassap::RestClient.new.run