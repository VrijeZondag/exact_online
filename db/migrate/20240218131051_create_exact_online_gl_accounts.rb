# frozen_string_literal: true

class CreateExactOnlineGlAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_gl_accounts do |t|
      t.string :guid, null: false, index: { unique: true }
      t.decimal :code, null: false, index: { unique: true }
      t.string :description
      t.string :account_type

      t.timestamps
    end
  end
end
