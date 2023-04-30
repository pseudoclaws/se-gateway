# frozen_string_literal: true

Rails.configuration.container.namespace(:se_api) do
  register :prepare_data, -> { SeApi::PrepareImportData.new }
  register :list_entities, -> { SeApi::ListEntities.new }
  register :request, -> { SeApi::Request.new }

  namespace(:accounts) do
    register :list, -> { SeApi::Accounts::List.new }
  end

  namespace(:connections) do
    register :retrieve, -> { SeApi::Connections::Retrieve.new }
    register :refresh, -> { SeApi::Connections::Refresh.new }
    register :reconnect, -> { SeApi::Connections::Reconnect.new }
    register :destroy, -> { SeApi::Connections::Destroy.new }
    register :list, -> { SeApi::Connections::List.new }
    register :create_session, -> { SeApi::Connections::CreateSession.new }
  end

  namespace(:customers) do
    register :create, -> { SeApi::Customers::Create.new }
    register :list, -> { SeApi::Customers::List.new }
  end

  namespace(:transactions) do
    register :list, -> { SeApi::Transactions::List.new }
  end
end

