class ChangeOwnersToAccountHoldersInBankAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bank_accounts, :owner, polymorphic: true
    remove_reference :bank_accounts, :organization
    add_reference :bank_accounts, :account_holder, polymorphic: true, index: false, type: :uuid
    add_index :bank_accounts, %i[account_holder_id account_holder_type], name: :index_bank_accounts_on_account_holder
  end
end
