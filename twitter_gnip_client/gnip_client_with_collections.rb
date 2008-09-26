require 'rubygems'
require 'gnip'

module Twitter
  
  class GnipClientWithCollections
    
    def run
      gnip = Gnip::Connection.new(Gnip::Config.new("brian.dainton@gmail.com", 
        password_from_disk))

      # create a server-side collection of user ids
      collection = Gnip::Collection.new("fiveruns-dev-#{Time.now.to_i}")
      
      user_list.each { |user| collection.add_uid(user, 'twitter') }
      collection.add_uid('bdainton', 'identica')
      
      gnip.create(collection)
      
      loop do
        time_spent = stopwatch do
          response, activities = gnip.activities_stream(collection)
          puts "#{activities.size} total twitter updates for users in my collection"
          puts activities.inspect
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
          'mmond',          
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

Twitter::GnipClientWithCollections.new.run