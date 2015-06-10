class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :group, index: true
      t.references :user, index: true
      t.datetime :published_at
      t.datetime :deadline

      t.timestamps
    end
  end
end
