# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    super do |user|
      CustomerJob.perform_async(user.id)
    end
  end
end
