class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.string     :name
      t.references :component_category
      t.string     :img_path
      t.integer    :stock
      
      t.timestamps
    end
  end
end
