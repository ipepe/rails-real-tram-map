class CreateTrams < ActiveRecord::Migration
  def change
    create_table :trams do |t|
      t.float :latitude
      t.float :longitude

      t.float :previous_latitude
      t.float :previous_longitude

      t.string :line
      t.string :brigade

      t.timestamps
    end
  end
end
