class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :answer, index: true
      t.references :dish, index: true

      t.timestamps
    end
  end
end
