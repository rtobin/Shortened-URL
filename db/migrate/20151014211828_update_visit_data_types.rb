class UpdateVisitDataTypes < ActiveRecord::Migration
  def change
    remove_column :visits, :url_id
    remove_column :visits, :user_id
    add_column :visits, :url_id, :integer
    add_column :visits, :user_id, :integer
    add_index(:visits, :url_id)
    add_index(:visits, :user_id)
  end
end
