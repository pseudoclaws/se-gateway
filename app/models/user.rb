class User < ApplicationRecord
  include AASM

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  include DeviseTokenAuth::Concerns::User

  has_one :customer, dependent: :destroy

  has_many :connections, through: :customer

  enum customer_state: {
    pending: 'pending',
    in_progress: 'in_progress',
    finished: 'finished',
    failed: 'failed'
  }

  aasm column: :customer_state do
    state :pending, initial: true
    state :in_progress, :finished, :failed

    event :run do
      transitions from: %i[pending failed], to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :finished
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end
  end
end
