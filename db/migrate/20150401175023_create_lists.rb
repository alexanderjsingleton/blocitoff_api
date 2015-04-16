class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :lists, :users
  end
end