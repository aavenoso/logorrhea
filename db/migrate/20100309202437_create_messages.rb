class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.text :body
      t.integer :priority
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
