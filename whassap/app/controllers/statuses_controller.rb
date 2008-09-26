class StatusesController < ApplicationController
  
  before_filter :find_user
  
  def create    
    status = @user.statuses.create(params[:status])
    
    respond_to do |format|  
      # site    
      format.html do
        if status.valid?
          flash[:notice] = 'Thanks for updating your Whassap status!'
          status.send_im
        else
          flash[:status] = 'bad'
          flash[:notice] = status.errors.full_messages.to_sentence
        end
        redirect_to user_path(status.user)
      end
      
      # API
      format.xml do
        if status.valid?
          status.send_im
          render :xml => status.to_xml
        else         
          render :text => status.errors.full_messages.to_sentence, :status => 400
        end
      end
    end
  end
  
  def index
    user = User.find_by_name(params[:user_id])
    @statuses = user.statuses.find(:all, :limit => 5)
    
    respond_to do |format|     
      format.xml { render :xml => @statuses.to_xml }
    end
  end
  
  #######
  private
  #######

  def find_user
    @user = User.find_by_name(params[:user_id])
  end
  
end
