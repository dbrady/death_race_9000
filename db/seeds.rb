# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'csv'
require 'faker'


# ========================================================================
# IMPORT CUSTOMERS
puts "Importing customers..."
Customer.destroy_all
CSV.parse(IO.readlines(Rails.root + "db/customers.csv").map(&:strip) * "\n", headers: true).each do |row|
  h = Hash[row.map{ | k,v| [k.downcase, v]}].tap { |h| h["name"] = h.delete("company") }
  Customer.create h
end


# ========================================================================
# CREATE USERS
puts "Creating users..."
User.destroy_all

def new_user(first_name, last_name, role=:employee)
  user = User.create(email: "#{first_name}.#{last_name}@example.com",
                     password: "pigtruck",
                     first_name: first_name,
                     last_name: last_name)
  user.roles << :admin
  user.save!
end

new_user "Seiko", "Wacobee", :admin
new_user "David", "Brady", :employee
new_user "Alice", "Johnson", :employee

# ========================================================================
# Projects
puts "Creating Projects for Customers..."
Customer.all.each do |customer|
  (1+rand(3)).times do
    Project.create!(customer: customer, name: Faker::App.name) do |project|
      project.tasks << Task.new(project: project, name: "Development")
      project.tasks << Task.new(project: project, name: "Meetings")
      project.tasks << Task.new(project: project, name: "Testing")
    end
  end
end
