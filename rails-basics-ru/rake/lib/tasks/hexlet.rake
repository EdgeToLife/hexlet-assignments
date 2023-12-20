require 'csv'

namespace :hexlet do
  desc "Import users"
  task :import_users, [:file] => :environment do |t, args|
    print "Task started...\n"
    print "Parse file #{args[:file]}"

    CSV.foreach("#{args[:file]}", headers: true) do |row|
      User.create(first_name: row['first_name'],
                  last_name: row['last_name'],
                  birthday: Date.strptime(row['birthday'], '%m/%d/%Y'),
                  email: row['email'])
    end

    print "\n...done\n"
  end

end
