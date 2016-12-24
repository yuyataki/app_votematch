class Party < ApplicationRecord
  has_many :scores, class_name: 'QuestionScore', dependent: :destroy
  belongs_to :previous_party, class_name: 'Party', foreign_key: :previous_party_id

  enum action: {
    found: 1, # 結党
    dissolve: 2, # 解党
    rename: 3, # 党名変更
    acquire_party_condition: 4, # 政党要件取得
    lose_party_condition: 5, # 政党要件喪失
    found_witouht_party_condition: 6, # 政党要件なしで結党
  }

  t = arel_table
  scope :active, ->(time) {
    found.or(rename).or(acquire_party_condition).where(
      t[:acted_on].lteq(time).and(t[:ended_on].gt(time))
    )
  }
end
