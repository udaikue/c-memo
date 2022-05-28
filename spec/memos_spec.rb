# frozen_string_literal: true

require_relative '../memos'

RSpec.describe 'memos' do
  it 'shows title of memos' do
    get '/memos'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('メモ1')
  end

  it 'shows label of memos' do
    get '/memos/new'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('タイトル', 'メモ')
  end

  it 'shows details of memo' do
    get '/memos/1'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('メモ1の内容')
  end
end
