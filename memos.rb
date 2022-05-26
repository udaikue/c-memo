# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

before do
  File.open('data/memos.json') do |f|
    @memos = JSON.parse(f.read)
  end
end

get '/memos' do
  erb :index
end
