class CreateBundles < ActiveRecord::Migration[6.0]
  def change
    create_table :bundles do |t|
      t.string :title
      t.references :creator, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
