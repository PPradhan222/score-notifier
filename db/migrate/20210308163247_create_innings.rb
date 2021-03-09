class CreateInnings < ActiveRecord::Migration[6.0]
  def change
    create_table :innings do |t|
      t.string :name
      t.integer :runs
      t.integer :wickets
      t.string :status
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
