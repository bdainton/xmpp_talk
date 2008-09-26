  
class TrafficGenerator
  
  def run(args)
    if args.size < 2
      print_usage
      return
    end
    
    case args[1]
    when 'twitter'
      print_twitter_traffic(args[0])
    when 'flickr'
      print_flickr_traffic(args[0])
    end
  end
  
  #######
  private
  #######
  
  def print_usage
    puts
    puts "USAGE: ruby traffic.rb [post | get] [twitter | flickr]"
  end
  
  def print_twitter_traffic(http_method)
    case http_method
    when 'post'
      print_traffic(10, "[TWITTER] Twitter status (tweet) created via POST")
    when 'get'
      print_traffic(200, "[TWITTER] Twitter polling: API request made via GET")
    else
      print_usage
    end
  end
  
  def print_flickr_traffic(http_method)
    case http_method
    when 'post'
      print_traffic(60, "[FLICKR] Flickr image uploaded via POST")
    when 'get'
      print_traffic(200, "[FLICKR] Flickr polling: API request made via GET")
    else
      print_usage
    end  
  end
  
  def print_traffic(num_per_second, text)
    interval = 1.0 / num_per_second
    num_printed = 0
    target = num_per_second * 5
    loop do
      num_printed += 1
      puts "#{text} #{num_printed}"
      break if num_printed >= target
      sleep interval
    end
    puts
    puts "---------------------------------------------------------------"
    puts "TOTAL #{num_printed} requests in 5 seconds"
    puts "---------------------------------------------------------------"    
  end
  
end

TrafficGenerator.new.run(ARGV)