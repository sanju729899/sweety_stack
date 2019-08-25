class AddReadedDate < ActiveRecord::Migration[5.2]
  def self.up
  	add_column :readings, :readed_date, :datetime
  end
  def self.down
  	remove_column :readings ,:readed_date
  end
end
