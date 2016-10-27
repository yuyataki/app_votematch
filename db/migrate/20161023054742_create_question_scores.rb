class CreateQuestionScores < ActiveRecord::Migration[5.0]
  def change
    create_table :question_scores do |t|
      t.references :question, null: false
      t.references :party, null: false
      t.integer :score_agree, limit: 1, null: false
      t.integer :score_neutral, limit: 1, null: false
      t.integer :score_opposition, limit: 1, null: false

      t.timestamps
    end
    add_foreign_key :question_scores, :questions
    add_foreign_key :question_scores, :parties
    add_index :question_scores, [:question_id, :party_id], unique: true
  end
end
