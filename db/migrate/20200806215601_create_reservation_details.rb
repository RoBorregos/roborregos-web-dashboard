class CreateReservationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_details do |t|
      t.references :reservation
      t.references :component
      t.boolean    :returned
      t.datetime   :returned_at

      t.timestamps
    end
  end
end
