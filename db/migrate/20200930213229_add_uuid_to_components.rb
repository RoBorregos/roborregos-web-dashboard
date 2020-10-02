class AddUuidToComponents < ActiveRecord::Migration[5.2]
  def change
    add_column :components, :uuid, :string
  end
end
