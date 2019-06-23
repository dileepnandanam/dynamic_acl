desc "Create migratio for acls"
task :create_acl do
  File.open("db/migrate/#{Time.now.to_s.gsub!(/[-\s:]/, '')}_create_acl.rb", 'w') do |f|
    f.puts %{
class CreateAcl < ActiveRecord::Migration[5.2]
  def change
    create_table :acls do |t|
      t.integer :user_id
      t.string :user_type
      t.string :action
      t.string :state
      t.string :object_type
    end
  end
end
    }
  end

  system("rake db:migrate")
end
