class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :url_id
      t.string :user_id

      t.timestamps
    end
  end
end
