class CreateUserTryHistoryRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_try_history_relationships, primary_key: %i(user_id try_history_id) do |t|
      t.references :user, null: false
      t.references :try_history, nul: false

      t.timestamps
    end
  end
end
