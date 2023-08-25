class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :status
      t.string :city
      t.string :location
      t.integer :avg_rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
