# Sinatra memo.app
## 概要
これはFjordBootCampの提出課題である、Sinatraを使ったメモアプリです。<br>
作成したメモは`memo_data`ディレクトリ配下にjsonファイルとして保存されます。<br>
メモの新規作成、編集、削除、トップページにメモの一覧表示をすることができます。
## 利用手順
`git clone`でローカルリポジトリとして取得
```
% git clone git@github.com:Shunta-Kogen/Sinatra_memo_app.git
```
`Sinatra_memo_app`ディレクトリでgemをインストール
```
% bundle install
```
`app.rb`を実行
```
% bundle exec ruby app.rb
```
ブラウザで http://localhost:4567/memos にアクセス