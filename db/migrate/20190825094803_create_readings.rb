class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.integer :blood_sugar
      t.timestamps
    end
  end
end
