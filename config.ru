require 'sinatra'
require 'sequel'
$stdout.sync = true

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
