require 'rubygems'
require 'xmpp4r-simple'
require 'httparty'

module Whassap
  
  class StatusBot
    include HTTParty
    base_uri 'localhost:3000'
    format :xml
    
    attr_reader :im
    
    def run
      @im = Jabber::Simple.new("whassap_status_bot@tiamat.local", "test")
      puts "Whassap Status Bot started.  Listening..."
      listen
    end
    
    #######
    private
    #######
    
    def listen
      loop do  
        im.received_messages do |msg|       
          puts "[#{msg.from.node}] #{msg.body}" if msg.type == :chat
          user = msg.from.node
                    
          self.class.post("/users/#{user}/statuses.xml", 
            :query => {:status => {:body => msg.body}})
          im.deliver(msg.from.to_s, "Got it.  Thanks!")
        end
        
        # wait a bit
        sleep 1
      end
    end
    
  end
end

Whassap::StatusBot.new.run