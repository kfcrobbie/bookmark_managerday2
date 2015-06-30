require 'sinatra/base'
require 'data_mapper'
require_relative './models/link'
require './data_mapper_setup'


class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  p 'in BookmarkManager'

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  p 'in BookmarkManager'

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do 
    Link.create(url: params[:url], title: params[:title])
    redirect to ('/links')
  end

end
