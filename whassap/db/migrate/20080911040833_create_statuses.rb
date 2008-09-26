class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :user_id
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
