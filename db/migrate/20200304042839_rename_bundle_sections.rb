class RenameBundleSections < ActiveRecord::Migration[6.0]
  def up
    rename_table :bundle_sections, :bundle_contributions
    rename_column :bundle_contributions, :section_order, :contribution_order
  end

  def down
    rename_table :bundle_contributions, :bundle_sections
    rename_column :bundle_contributions, :contribution_order, :section_order
  end
end
