class AddUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
    end

    add_column :posts, :user_id, :reference
  end

  def down
    remove_column :posts, :user_id

    drop_table :users
  end
end
