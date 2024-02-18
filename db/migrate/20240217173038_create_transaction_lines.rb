# frozen_string_literal: true

class CreateTransactionLines < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_transaction_lines do |t|
      t.string :guid, null: false, index: { unique: true }
      t.decimal :amount
      t.date :date
      t.string :description
      t.string :entryId
      t.decimal :financialPeriod
      t.decimal :financialYear
      t.decimal :glAccountCode
      t.string :glAccountId
      t.string :glAccountDescription
      t.decimal :journal

      t.timestamps
    end
  end
end
