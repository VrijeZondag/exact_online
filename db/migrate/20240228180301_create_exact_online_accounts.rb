# frozen_string_literal: true

class CreateExactOnlineAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_accounts do |t|
      t.string :exact_id
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.string :postcode
      t.string :phone
      t.string :status
      t.string :code
      t.string :is_sales
      t.string :is_supplier
      
      t.timestamps
    end
  end
end
