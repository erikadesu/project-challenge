class AddOwnerToDogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :dogs, :owner, references: :users, index: true

    add_foreign_key :dogs, :users, column: :owner_id
  end
end
