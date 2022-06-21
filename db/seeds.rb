# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

# Generate clients from seed
csv_clients_text = File.read(Rails.root.join('lib', 'seeds', 'korisnic.csv'))
csv_clients = CSV.parse(csv_clients_text, :headers => true, :encoding => 'UTF-8')
csv_clients.each do |row|
  t = Client.new
  t.id = row['id']
  t.first_name = row['first_name'].nil? ? row['first_name'] : row['first_name'].strip
  t.last_name = row['last_name'].nil? ? row['last_name'] : row['last_name'].strip
  t.phone_num = row['phone_num'].nil? ? row['phone_num'] : row['phone_num'].strip
  t.comment = row['comment'].nil? ? row['comment'] : row['comment'].strip
  t.save
  puts "#{t.id} - #{t.first_name}, #{t.last_name} saved"
end

puts "There are now #{Client.count} rows in the clients table"

# Generate treatments from seed
csv_treatments_text = File.read(Rails.root.join('lib', 'seeds', 'rad.csv'))
csv_treatments = CSV.parse(csv_treatments_text, :headers => true, :encoding => 'UTF-8')
csv_treatments.each do |row|
  user = User.find(row['client_id'])
  date = row['date'].nil? ? row['date'] : row['date'].strip
  description = row['treatment'].nil? ? row['treatment'] : row['treatment'].strip
  user.treatments.create!(date: date, description: description)
end

puts "There are now #{Treatment.count} rows in the treatments table"