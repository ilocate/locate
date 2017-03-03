class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.integer :user_id
      t.datetime :start_at
      t.datetime :end_at
      t.integer :label_id
      t.string :note
      t.boolean :is_manual

      t.timestamps
    end
  end
end
