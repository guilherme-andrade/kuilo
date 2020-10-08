class ContractsStatusCheckJob < ApplicationJob
  include DateHelper

  queue_as :contracts

  def perform
    Contract.find_each(&method(:perform_status_check))
  end

  private

  def perform_status_check(contract)
    return if contract.cancelled? || contract.terminated?

    send("#{contract.status}_check", contract)
  end

  def in_negotiation_check(contract)

  end

  def signed_check(contract)

  end

  def confirmed_check(contract)

  end

  def activated_check(contract)

  end

  def in_notice_check(contract)

  end

  def terminated_check(contract)

  end
end
