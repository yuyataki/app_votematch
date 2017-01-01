class UserTryHistoryRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :try_history
end
