require 'sinatra'
require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])
DB.create_table? :beers do
  primary_key :id
  String :region
  String :brand
end

get '/' do
  erb :index, :locals => {:data =>  DB[:beers]}
end

post '/create' do
  DB[:beers].insert(params)
  redirect '/'
end
