class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents, force: :cascade do |t|
      t.string :name
      t.boolean :approved
      t.references :directory, foreign_key: true
      t.timestamps
    end
  end
end
