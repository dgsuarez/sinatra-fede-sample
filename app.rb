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

get "/posts/new" do
  @post = Post.new
  @action = "/posts"
  erb :"posts/form.html"
end

post "/posts" do
  Post.create(params[:post])
  redirect "/posts"
end

get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @action = "/posts/#{@post.id}"
  erb :"posts/form.html"
end

post "/posts/:id" do
  post = Post.find(params[:id])
  post.update_attributes(params[:post])
  redirect "/posts"
end

