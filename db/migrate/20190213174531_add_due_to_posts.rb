class AddDueToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :due, :date
  end
end
