# frozen_string_literal: true

Rails.configuration.container.namespace(:users) do
  register :create, -> { Users::Create.new }
end

