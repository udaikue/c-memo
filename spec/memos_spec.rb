# frozen_string_literal: true

require_relative '../memos'

RSpec.describe 'memos' do
  it 'shows title of memos' do
    get '/memos'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('メモ1', 'メモ2')
  end
end
