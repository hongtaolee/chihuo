class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :group, index: true

      t.timestamps
    end
  end
end
