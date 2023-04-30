# frozen_string_literal: true

class Api::V1::AccountsController < Api::V1::BaseController
  include AutoInject[
    list_transactions: 'se_api.transactions.list'
  ]

  def show
    list_transactions.call(account)
  rescue GatewayApiException, Faraday::ConnectionFailed
    outdated = true
  ensure
    render json: { transactions:, outdated: }
  end

  private

  def connection
    @connection ||= current_user.connections.find_by!(external_id: params[:connection_id])
  end

  def account
    @account ||= connection.accounts.find_by!(external_id: params[:id])
  end

  def transactions
    account.transactions.map do |transaction|
      TransactionSerializer.new(transaction).serializable_hash
    end
  end
end
