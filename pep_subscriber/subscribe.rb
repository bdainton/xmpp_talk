require 'rubygems'
require 'xmpp4r-simple'

module Demo
  
  class PepSubscriber
    
    def run(args)
      if args.size < 2
        print_usage
        return
      end
      if args[0] == '-u'
        unsubscribe(args[1], args[2])
      else
        subscribe(args[0], args[1])
      end
    end
    
    #######
    private
    #######
    
    def subscribe(subscriber, publisher)
      pubsub = pubsub_handle_for(subscriber)
      pubsub.subscribe_to("/home/tiamat.local/#{publisher}")
      
      puts "SUBSCRIBED! '#{subscriber}@tiamat.local' is now following '#{publisher}@tiamat.local'"
    end
    
    def unsubscribe(subscriber, publisher)      
      pubsub = pubsub_handle_for(subscriber)
      pubsub.unsubscribe_from("/home/tiamat.local/#{publisher}")
      
      puts "UNSUBSCRIBED!: '#{subscriber}@tiamat.local' is NO LONGER following '#{publisher}@tiamat.local'"
    end
    
    def pubsub_handle_for(subscriber)    
      im = Jabber::Simple.new("#{subscriber}@tiamat.local", "test")
      Jabber::PubSub::ServiceHelper.new(im.client, "pubsub.tiamat.local")
    end
    
    def print_usage
      puts "ruby subscribe.rb [-u] subscriber_name publisher_name"
    end
    
  end
  
end

Demo::PepSubscriber.new.run(ARGV)