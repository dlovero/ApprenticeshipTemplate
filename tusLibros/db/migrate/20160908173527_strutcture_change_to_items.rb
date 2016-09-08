class StrutctureChangeToItems < ActiveRecord::Migration
  def change
    remove_column :items,:sale_id
  end
end
