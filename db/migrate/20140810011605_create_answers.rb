class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true
      t.references :survey, index: true

      t.timestamps
    end
  end
end
