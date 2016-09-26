require 'sinatra'
require 'sequel'
$stdout.sync = true


log_file = File.open(yourfile, 'w')

DB = Sequel.connect(ENV["DATABASE_URL"])
DB.create_table? :beers do
  primary_key :id
  String :region
  String :brand
end

get '/' do
  log_file.write("Someone requested for beers!\n")
  erb :index, :locals => {:data =>  DB[:beers]}
end

post '/create' do
  log_file.write("Someone added a new beer!\n")
  DB[:beers].insert(params)
  redirect '/'
end
