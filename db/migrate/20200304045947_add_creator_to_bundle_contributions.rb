class AddCreatorToBundleContributions < ActiveRecord::Migration[6.0]
  def change
    add_reference :bundle_contributions, :creator, foreign_key: {to_table: :users}
  end
end
