require 'rubygems'
require 'sinatra'

get '/hello/:name' do
  # "GET /hello/** ==> params[:name] : **
  "Hello #{params[:name]} !"
end
