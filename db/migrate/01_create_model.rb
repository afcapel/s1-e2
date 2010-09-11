class CreateModel < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :commits_count, :default => 0
      t.timestamps
    end
    
    create_table :commits do |t|
      t.string :message
      t.integer :user_id
      t.timestamps
    end
    
    create_table :achivements do |t|
      t.string :description
      t.string :type
      t.integer :user_id
      t.timestamps
    end
    
  end

  def self.down
    drop_table :users
    drop_table :commits
    drop_table :achivements
  end
end