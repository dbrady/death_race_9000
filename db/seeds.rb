# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


# ========================================================================
# IMPORT CUSTOMERS
require 'csv'

puts "Importing customers..."
Customer.destroy_all
CSV.parse(IO.readlines(Rails.root + "db/customers.csv").map(&:strip) * "\n", headers: true).each do |row|
  h = Hash[row.map{ | k,v| [k.downcase, v]}].tap { |h| h["name"] = h.delete("company") }
  Customer.create h
end

puts "Creating users..."
User.destroy_all
seiko = User.create(email: "Seiko.Wacobee@example.com",
                    password: "pigtruck",
                    first_name: "Seiko",
                    last_name: "Wacobee")
seiko.roles << :admin
seiko.save

puts "Creating Projects for Customers..."

puts "Creating Tasks for all Customers..."
