# frozen_string_literal: true

Rails.configuration.container = Dry::Container.new
AutoInject = Dry::AutoInject(Rails.configuration.container)
