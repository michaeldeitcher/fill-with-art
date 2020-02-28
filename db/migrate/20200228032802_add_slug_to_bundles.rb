class AddSlugToBundles < ActiveRecord::Migration[6.0]
  def change
    add_column :bundles, :slug, :string
    add_index :bundles, :slug, unique: true
  end
end
