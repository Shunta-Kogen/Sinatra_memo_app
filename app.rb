# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'pg'

CONNECTION = PG.connect(dbname: 'sinatra_memo')

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def insert_memo(memo_id, title, content)
  CONNECTION.exec('INSERT INTO memos VALUES ($1, $2, $3);', [memo_id, title, content])
end

def update_memo(memo_id, title, content)
  CONNECTION.exec('UPDATE memos SET title = $1, content = $2 WHERE memo_id = $3;', [title, content, memo_id])
end

def delete_memo(memo_id)
  CONNECTION.exec('DELETE FROM memos WHERE memo_id = $1;', [memo_id])
end

def select_memo(memo_id)
  CONNECTION.exec('SELECT * FROM memos WHERE memo_id = $1;', [memo_id]).to_a
end

def select_memos
  CONNECTION.exec('SELECT * FROM memos;').to_a
end

# トップページ
get '/memos' do
  @memos = select_memos.reverse
  erb :top
end

post '/memos' do
  memo_id = SecureRandom.alphanumeric
  @title = params[:title]
  @content = params[:content]
  insert_memo(memo_id, @title, @content)
  redirect to('/memos')
end

# 新規作成ページ
get '/memos/new' do
  erb :new
end

# メモ表示ページ
get '/memos/:id' do
  memo_id = params[:id]
  @memos = select_memo(memo_id)
  erb :show
end

patch '/memos/:id' do
  memo_id = params[:id]
  title = params[:title]
  content = params[:content]
  update_memo(memo_id, title, content)
  redirect to("/memos/#{params[:id]}")
end

delete '/memos/:id' do
  memo_id = params[:id]
  delete_memo(memo_id)
  redirect to('/memos')
end

# メモ編集ページ
get '/memos/:id/edit' do
  memo_id = params[:id]
  @memos = select_memo(memo_id)
  erb :edit
end
