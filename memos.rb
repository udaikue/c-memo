# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

before do
  open('data/memos.json') do |m|
    @memos_json = JSON.parse(m)
  end
end

get '/memos' do
  erb :index
end
