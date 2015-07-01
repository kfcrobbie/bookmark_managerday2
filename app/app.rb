require 'sinatra/base'
require 'data_mapper'
require './app/models/link'
require './data_mapper_setup'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'


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

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save # #save returns true/false depending on whether the model is successfully saved to the database.
      session[:user_id] = @user.id
      redirect to('/links')
      # if it's not valid,
      # we'll show the same
      # form again
    else
      flash.now[:notice] = 'Sorry, your passwords do not match'
      erb :'users/new'
    end
  end

  helpers do
    def current_user
      current_user = User.get(session[:user_id])
    end
  end
end
