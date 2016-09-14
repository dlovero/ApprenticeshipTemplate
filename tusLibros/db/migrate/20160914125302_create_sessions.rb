class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :last_time_used
      t.references :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
