class AddsCoachNameToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :coach_name, :string
  end
end
