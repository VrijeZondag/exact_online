# frozen_string_literal: true

class CreateExactOnlineGlClassifications < ActiveRecord::Migration[7.1]
  def change
    create_table :exact_online_gl_classifications do |t|
      t.string :guid, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }
      t.string :description
      t.string :name
      t.string :parent
      t.string :namespace
      t.string :classification_type

      t.timestamps
    end
  end
end
