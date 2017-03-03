class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :nickname
      t.string :phone
      t.string :encrypted_password
      t.boolean :sex
      t.integer :age
      t.string :bio
      t.string :avatar
      t.integer :state
      t.text :setting

      t.timestamps
    end
  end
end
