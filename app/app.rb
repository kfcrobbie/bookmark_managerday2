require 'sinatra/base'
require 'data_mapper'
require_relative './models/link'
require './data_mapper_setup'


class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
  redirect to('/links')

  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do 
    link = Link.new(url: params[:url],     # 1. Create a link
                title: params[:title])
  tag  = Tag.create(name: params[:tag]) # 2. Create a tag for the link
  link.tags << tag                       # 3. Adding the tag to the link's DataMapper collection.
  link.save 
    redirect to ('/links')
  end

end
