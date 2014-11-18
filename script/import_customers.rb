# run me with rails r!
require 'csv'


unless ARGV[0]
  puts "rails r script/import_customers.rb <csv_file>"
end


Customer.destroy_all
CSV.parse(IO.readlines(ARGV[0]).map(&:strip) * "\n", headers: true).each do |row|
  h = Hash[row.map{ | k,v| [k.downcase, v]}].tap { |h| h["name"] = h.delete("company") }
  c = Customer.create h
  puts c.name
end
