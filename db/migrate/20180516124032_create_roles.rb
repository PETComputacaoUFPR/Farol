class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
    	t.string "name"
	    t.string "resource_type"
	    t.integer "resource_id"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
	    t.index ["name"], name: "index_roles_on_name"
	    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
    end
  end
end
