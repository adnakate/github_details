class User < ApplicationRecord
  has_many :repositories
  has_many :commits
end
