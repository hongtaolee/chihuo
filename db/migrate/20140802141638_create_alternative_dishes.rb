class CreateAlternativeDishes < ActiveRecord::Migration
  def change
    create_table :alternative_dishes do |t|
      t.references :survey, index: true
      t.references :dish, index: true

      t.timestamps
    end
  end
end
