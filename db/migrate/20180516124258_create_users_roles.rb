class CreateUsersRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :users_roles do |t|
    	t.references :user
    	t.references :role
    	# t.integer "user_id"
	    # t.integer "role_id"
	    # t.index ["role_id"], name: "index_users_roles_on_role_id"
	    # t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
	    # t.index ["user_id"], name: "index_users_roles_on_user_id"
    end
  end
end
