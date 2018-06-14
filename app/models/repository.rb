class Repository < ApplicationRecord
  belongs_to :user
  has_many :commits
end
