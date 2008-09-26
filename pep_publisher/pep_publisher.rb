require 'rubygems'
require 'xmpp4r-simple'

module Demo
  
  class PepPublisher
    
    attr_reader :im
    
    def run
      @im = Jabber::Simple.new("brian@tiamat.local", "test")
      
      loop do
        message = "The time right now is #{Time.now}"
        im.publish(message)
        puts "PUBLISHED: #{message}"
        sleep 3
      end
    end
    
  end
  
end

Demo::PepPublisher.new.run