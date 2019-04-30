class AddCreatedByToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :created_by, :string
  end
end
