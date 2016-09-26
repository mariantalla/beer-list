require 'sinatra'
require 'sequel'
$stdout.sync = true

raise "Could not find MUST_EXIST in environment" unless ENV["MUST_EXIST"]

DB = Sequel.connect(ENV["DATABASE_URL"])
DB.create_table? :beers do
  primary_key :id
  String :region
  String :brand
end

get '/' do
  puts("Someone requested for beers!\n")
  erb :index, :locals => {:data =>  DB[:beers]}
end

post '/create' do
  puts("Someone added a new beer!\n")
  DB[:beers].insert(params)
  redirect '/'
end
