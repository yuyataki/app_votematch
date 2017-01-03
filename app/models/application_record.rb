class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.latest
    order(:id).last
  end
end
