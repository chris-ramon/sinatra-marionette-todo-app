require 'sinatra/base'
require './models/todo'

class TodoApp < Sinatra::Base
  get '/' do
    redirect '/todos'
  end

  get '/todos' do
    @todos = Todo.all
    erb :'todos/list'
  end

  get %r{/todos/(\d+)} do
    @todo = Todo[params[:captures][0]]
    if @todo
      erb :'todos/show'
    else
      # not found
    end
  end

  get '/todos/new' do
    erb :'todos/new'
  end

  post '/todos/new' do
    Todo.create :text => params[:text], :status => params[:status]
    redirect '/todos'
  end

  post %r{/todos/edit/(\d+)} do
    @todo = Todo[params[:captures][0]]
    if @todo
      @todo.update({text: params[:text], status: !params[:status].nil?})
      redirect "/todos/#{@todo.id}"
    else
      # not found
    end
  end

  get %r{/todos/edit/(\d+)} do
    @todo = Todo[params[:captures][0]]
    if @todo
      erb :'todos/edit'
    else
      # not found
    end
  end

  get %r{/todos/delete/(\d+)} do
    @todo = Todo[params[:captures][0]]
    if @todo
      @todo.delete
      redirect '/todos'
    else
      # not found
    end
  end

  run!
end