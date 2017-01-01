class TryScore < ApplicationRecord
  belongs_to :try_history
  belongs_to :party
end
