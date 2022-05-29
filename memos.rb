# frozen_string_literal: true

require 'pg'
require 'sinatra'
require 'sinatra/reloader'

class Memo
  def self.db_connect
    @connection = PG.connect(dbname: 'memo')
  end

  def self.all
    @connection.exec('SELECT * FROM memos ORDER BY id;')
  end

  def self.details(id)
    @connection.exec('SELECT id, title, content FROM memos WHERE id=$1;', [id])
  end

  def self.add(title, content)
    @connection.exec('INSERT INTO memos (title, content) VALUES ($1, $2);', [title, content])
  end

  def self.update(id, title, content)
    @connection.exec('UPDATE memos SET title=$1, content=$2 WHERE id=$3;', [title, content, id])
  end

  def self.delete(id)
    @connection.exec('DELETE FROM memos WHERE id=$1;', [id])
  end

  def self.db_disconnect
    @connection.finish
  end

  def self.db
    db_connect
    yield
    db_disconnect
  end
end

get '/memos' do
  Memo.db do
    @memos = Memo.all
  end
  erb :index
end

post '/memos' do
  title = params[:title]
  content = params[:content]
  Memo.db do
    Memo.add(title, content)
  end
  redirect to('/memos')
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @id = params[:id]
  Memo.db do
    @memo = Memo.details(@id)
  end
  erb :show
end

get '/memos/:id/edit' do
  @id = params[:id]
  Memo.db do
    @memo = Memo.details(@id)
  end
  erb :edit
end

patch '/memos/:id' do
  id = params[:id]
  title = params[:title]
  content = params[:content]
  Memo.db do
    Memo.update(id, title, content)
  end
  redirect to('/memos')
end

delete '/memos/:id' do
  @id = params[:id]
  Memo.db do
    Memo.delete(@id)
  end
  redirect to('/memos')
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end
