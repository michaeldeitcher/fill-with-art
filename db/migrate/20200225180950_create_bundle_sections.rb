class CreateBundleSections < ActiveRecord::Migration[6.0]
  def change
    create_table :bundle_sections do |t|
      t.belongs_to :bundle
      t.integer :section_order
      t.text :text
      t.timestamps
    end
  end
end
