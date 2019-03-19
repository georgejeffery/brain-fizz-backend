class Addtone < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :tone, :string
  end
end
