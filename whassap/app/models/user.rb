class User < ActiveRecord::Base
  has_many :statuses, :order => 'created_at DESC'
  
  validates_uniqueness_of :name
  
  def to_param
    name
  end
end
