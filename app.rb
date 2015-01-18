require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'

configure do
  set :bind => "0.0.0.0"
  Mongoid.load!("config/mongoid.yml")

  Dir["models/**/*.rb"].each{|model| require_relative model }
end

get "/posts" do
  @posts = Post.all
  erb :"posts/index.html"
end

post "/posts" do
  Post.create(params[:post])
end

