class Party < ApplicationRecord
  has_many :question_scores
  belongs_to :previous_party, class_name: 'Party', foreign_key: :previous_party_id

  enum action: {
    found: 1, # 結党
    dissolve: 2, # 解党
    rename: 3, # 党名変更
    acquire_party_condition: 4, # 政党要件取得
    lose_party_condition: 5, # 政党要件喪失
    found_witouht_party_condition: 6, # 政党要件なしで結党
  }

  scope :active, ->(time) {
    found.or(rename).or(acquire_party_condition).where(
      acted_on: Time.zone.local(0)..time, ended_on: time..Time.zone.local(9999, 12, 31)
    )
  }
end
