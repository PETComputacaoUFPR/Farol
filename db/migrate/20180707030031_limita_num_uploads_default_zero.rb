class LimitaNumUploadsDefaultZero < ActiveRecord::Migration[5.1]
  def change
	change_column :users, :num_uploads, :integer, :default => 0
  end
end
