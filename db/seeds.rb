# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Provider.
provider = User.create!( :name => "Jeff",
                         :email => "provider@pd.com",
                         :password => "peakdemand",
                         :password_confirmation => "peakdemand",
                         :is_provider => true )

# Consumer.
consumer = User.create!( :name => "Aaron",
                         :email => "consumer@pd.com",
                         :password => "peakdemand",
                         :password_confirmation => "peakdemand",
                         :is_consumer => true )

# Resource.
cluster = Resource.create!( :name => "Cluster1",
                            :short_description => "For scientific computing",
                            :provider => provider,
                            :start_at => Date.today,
                            :end_at => Date.tomorrow.tomorrow,
                            :description => "We just updated the memory to 100000000 GB." )

printer = Resource.create!( :name => "Poster Printer 1",
                            :short_description => "For making greate posters",
                            :provider => provider,
                            :start_at => Date.yesterday,
                            :end_at => Date.tomorrow.tomorrow,
                            :description => "Please email your design to design@eecs.com first for review." )

# Demand.
Demand.create!( :short_description => "Siggraph Report Due",
                :intensity => "HEAVY",
                :resource => cluster,
                :consumer => consumer,
                :start_at => Date.today,
                :end_at => Date.today )

Demand.create!( :short_description => "New Matmul algorithm",
                :intensity => "MODERATE",
                :resource => cluster,
                :consumer => consumer,
                :start_at => Date.today,
                :end_at => Date.tomorrow )

Demand.create!( :short_description => "Routing work",
                :intensity => "LIGHT",
                :resource => cluster,
                :consumer => consumer,
                :start_at => Date.today,
                :end_at => Date.today )
