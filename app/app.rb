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
    link = Link.create(url: params[:url], title: params[:title])
    tags = params[:tag].split(' ')
    tags.each do |tag|
      link.tags << Tag.create(name: tag)
    end                      # 3. Adding the tag to the link's DataMapper collection.
    link.save
    redirect to ('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

end
