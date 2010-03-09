class CreatePipes < ActiveRecord::Migration
  def self.up
    create_table :pipes do |t|
      t.string :name
      t.string :material

      t.timestamps
    end
  end

  def self.down
    drop_table :pipes
  end
end
