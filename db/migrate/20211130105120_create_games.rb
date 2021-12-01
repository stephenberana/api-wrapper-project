class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :summary
      t.string :storyline
      t.integer :rating_count

      t.timestamps
    end
  end
end
