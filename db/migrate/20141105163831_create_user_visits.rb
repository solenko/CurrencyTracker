class User < ActiveRecord::Base

end
class CreateUserVisits < ActiveRecord::Migration
  def up
    create_table :user_visits do |t|
      t.integer  :user_id, :null => false
      t.string   :country_code, :null => false, :limit => 2
      t.datetime :created_at
    end
    add_index :user_visits, [:country_code, :user_id], :unique => true

    User.reset_column_information
    user = User.where(:email => "mr_smart@email.com").first_or_create!
    say_with_time("Move visits data to users_visits table") do
      execute sprintf("INSERT INTO user_visits SELECT NULL, %d, code, 'now' FROM countries WHERE visited = 1", user.id)
    end

    remove_column :countries, :visited
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
