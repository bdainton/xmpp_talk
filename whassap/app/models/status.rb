class Status < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :body  
  after_create :publish
  
  def send_im      
    begin
      NOTIFIER_BOT_CONNECTION.deliver(user.jid, 
        "Thanks! Your Whassap status was updated to: [#{user.description}] #{body}")
    rescue => e
      logger.warn "Couldn't IM JID '#{user.jid}': #{e.message}"
    end
  end
  
  def publish
    begin
      connection = Jabber::Simple.new(user.jid, 'test')
      connection.publish(body)
    rescue => e
      logger.warn "Couldn't IM JID '#{user.jid}': #{e.message}"
    end
  end
  
end
