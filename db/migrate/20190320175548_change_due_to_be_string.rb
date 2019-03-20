class ChangeDueToBeString < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :due, :string
  end
  
  def down
    change_column :posts, :due, :date
  end
end
