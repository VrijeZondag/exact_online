# frozen_string_literal: true

class CreateExactOnlineGlSchemes < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_gl_schemes do |t|
      t.string :guid, null: false, index: { unique: true }
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
