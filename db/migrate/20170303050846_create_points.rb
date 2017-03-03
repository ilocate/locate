class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.integer :track_id
      t.decimal :latitude
      t.decimal :longitude
      t.string :address

      t.timestamps
    end
  end
end
