# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :likeable_type
      t.integer :likeable_id
      t.integer :liked_by

      t.timestamps
    end
  end
end
