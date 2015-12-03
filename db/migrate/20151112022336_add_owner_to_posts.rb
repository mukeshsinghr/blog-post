class AddOwnerToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :owner, :integer
  end
end
