class AddMembersCountToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :members_count, :integer
  end
end
