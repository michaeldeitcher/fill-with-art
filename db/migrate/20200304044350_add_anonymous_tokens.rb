class AddAnonymousTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :bundles, :anonymous_token, :string
    add_column :bundle_contributions, :anonymous_token, :string
  end
end
