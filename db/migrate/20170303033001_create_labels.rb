class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.integer :user_id
      t.string :name
      t.boolean :is_open

      t.timestamps
    end
  end
end
