require 'rubygems'
require 'gnip'

module Twitter
  
  class GnipClient
    
    def run
      gnip = Gnip::Connection.new(Gnip::Config.new("brian.dainton@gmail.com", 
        password_from_disk))
      
      response, twitter = gnip.get_publisher('twitter')
      
      loop do
        time_spent = stopwatch do
          response, activities = gnip.activities_stream(twitter)
          puts "#{activities.size} total twitter updates"
          updates = activities.select do |activity| 
            user_list.include?(activity.uid) 
          end
          puts updates.inspect
        end
        puts "Took #{time_spent}s"
        sleep 10        
      end
    end
    
    #######
    private
    #######
    
    def user_list
      @user_list ||= ['alancfrancis',
          'bdainton', 
          'efalcao',      
          'mperham',
          'mswain',
          'stevesanderson',
          'therealadam',          
          'wbruce'
        ]      
    end
        
    def password_from_disk
      File.read(File.join(File.dirname(__FILE__), ".gnip_pass")).chomp
    end    
    
    def stopwatch(&block)
      start = Time.now
      yield
      Time.now - start
    end
  end
  
end

Twitter::GnipClient.new.run