class AddVisitIndex < ActiveRecord::Migration
  def change
    add_index(:visits, :url_id)
    add_index(:visits, :user_id)
  end
end
