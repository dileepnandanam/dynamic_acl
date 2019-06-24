namespace :dynamic_acl do
  desc "Create migratio for acls"
  task :install do
    content = File.open('config/routes.rb').read
    lines = content.split("\n")
    ends_at = lines.enum_for(:each_with_index).select{|line, index| line.include?('end')}.last.last
    lines[ends_at] = %{
  resources :dynamic_acls do
    put :set, on: :collection
  end
end
}
      binding.pry
    File.open('config/routes.rb', 'w') do |f|
      f.puts lines.join("\n")
    end

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
end
