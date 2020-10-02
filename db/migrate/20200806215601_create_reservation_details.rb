class CreateReservationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_details do |t|
      t.references :reservation
      t.references :component
      t.string     :uuid
      t.datetime   :delivered_at
      t.datetime   :received_at
      t.datetime   :returned_at
      t.integer    :status, :default => 1
      

      t.timestamps
    end
  end
end
