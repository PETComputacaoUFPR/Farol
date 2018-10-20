class LimitaNumeroUploads < ActiveRecord::Migration[5.1]
  def change
  add_column :users, :num_uploads, :integer, :default => "P"
  end
end
