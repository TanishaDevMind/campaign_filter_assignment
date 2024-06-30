class User < ApplicationRecord
    serialize :campaigns_list, JSON
    validates :campaigns_list, presence: true
  end
  