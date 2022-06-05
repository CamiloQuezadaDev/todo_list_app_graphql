class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :state, default: 'pending'
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
