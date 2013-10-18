class ChangePrivateToIsPrivate < ActiveRecord::Migration
  def change
    rename_column :goals, :private, :is_private
  end

end
