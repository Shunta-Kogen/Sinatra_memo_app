# Sinatra memo.app
## 概要
これはFjordBootCampの提出課題である、Sinatraを使ったメモアプリです。<br>
作成したメモは`sinatra_memo`データベースの`memos`テーブルに保存されます。<br>
RDBMSはPostgreSQLを使用します。<br>
メモの新規作成、編集、削除、トップページにメモの一覧表示をすることができます。
## 利用手順
### メモデータ保存用のテーブルを作成する
PostgreSQLへログイン
```
psql -U <ユーザー名>
```
`sinatra_memo`データベースを作成
```
CREATE DATABASE sinatra_memo;
```
`sinatra_memo`データベースに移動
```
/c sinatra_memo
```
`memos`テーブルを作成
```
CREATE TABLE memos
(memo_id TEXT NOT NULL,
title TEXT NOT NULL,
content TEXT,
PRIMARY KEY (memo_id));
```

### クローンをして実行
`git clone`でローカルリポジトリとして取得
```
git clone git@github.com:Shunta-Kogen/Sinatra_memo_app.git
```
`Sinatra_memo_app`ディレクトリでgemをインストール
```
bundle install
```
`app.rb`を実行
```
bundle exec ruby app.rb
```
ブラウザで http://localhost:4567/memos にアクセス
