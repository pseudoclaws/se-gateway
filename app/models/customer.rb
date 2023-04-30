class Customer < ApplicationRecord
  belongs_to :user
  has_many :connection_sessions, dependent: :destroy
  has_many :connections, dependent: :destroy
end
