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
end

get '/memos' do
  Memo.db_connect
  @memos = Memo.all
  Memo.db_disconnect
  erb :index
end

post '/memos' do
  title = params[:title]
  content = params[:content]
  Memo.db_connect
  Memo.add(title, content)
  Memo.db_disconnect
  redirect to('/memos')
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @id = params[:id]
  Memo.db_connect
  @memo = Memo.details(@id)
  Memo.db_disconnect
  erb :show
end

get '/memos/:id/edit' do
  @id = params[:id]
  Memo.db_connect
  @memo = Memo.details(@id)
  Memo.db_disconnect
  erb :edit
end

patch '/memos/:id' do
  id = params[:id]
  title = params[:title]
  content = params[:content]
  Memo.db_connect
  Memo.update(id, title, content)
  Memo.db_disconnect
  redirect to('/memos')
end

delete '/memos/:id' do
  @id = params[:id]
  Memo.db_connect
  Memo.delete(@id)
  Memo.db_disconnect
  redirect to('/memos')
end
