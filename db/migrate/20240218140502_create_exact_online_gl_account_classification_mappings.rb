# frozen_string_literal: true

class CreateExactOnlineGlAccountClassificationMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_gl_account_classification_mappings do |t|
      t.string :guid, null: false, index: { unique: true }

      t.string :classification_guid, null: false, index: true
      t.string :classification_code
      t.string :classification_description

      t.string :gl_account_guid, null: false, index: true
      t.string :gl_account_code
      t.string :gl_account_description

      t.string :gl_scheme_guid, null: false, index: true
      t.string :gl_scheme_code
      t.string :gl_scheme_description

      t.timestamps
    end
  end
end
