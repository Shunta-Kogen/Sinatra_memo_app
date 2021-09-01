# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def make_memo_file(memo_id, memo)
  File.open("memo_data/#{memo_id}.json", 'w') do |file|
    JSON.dump(memo, file)
  end
end

def read_memo_file(memo_id)
  memo_file = Dir.glob("memo_data/#{memo_id}.json")
  memo_file.map {|files| JSON.parse(File.open(files).read, symbolize_names: true) }
end

# トップページ
get '/memos' do
  asc_memo_filenames = Dir.glob('memo_data/*.json').sort_by {|file| File.mtime(file)}
  @desc_memo_filenames = asc_memo_filenames.reverse.map { |files| JSON.parse(File.open(files).read, symbolize_names: true) }
  erb :top
end

post '/memos' do
  memo_id = SecureRandom.alphanumeric
  @title = params[:title]
  @content = params[:content]
  memo = { 'memo_id' => memo_id.to_s, 'title' => @title, 'content' => @content }
  make_memo_file(memo_id, memo)
  redirect to('/memos')
end

# 新規作成ページ
get '/memos/new' do
  erb :new
end

# メモ表示ページ
get '/memos/:id' do
  memo_id = params[:id]
  @memo_files = read_memo_file(memo_id)
  erb :show
end

patch '/memos/:id' do
  memo_id = params[:id]
  memo = { 'memo_id' => params[:id].to_s, 'title' => params[:title], 'content' => params[:content] }
  make_memo_file(memo_id, memo)
  redirect to("/memos/#{params[:id]}")
end

delete '/memos/:id' do
  File.delete("memo_data/#{params['id']}.json")
  redirect to('/memos')
end

# メモ編集ページ
get '/memos/:id/edit' do
  memo_id = params[:id]
  @memo_files = read_memo_file(memo_id)
  erb :edit
end
