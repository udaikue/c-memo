# c-memo
Sinatra で作成したシンプルなメモアプリです。

# 実装について
## URL設計

|URL|HTTPメソッド|機能|
|---|---|---|
|/memos|GET|メモの一覧表示|
|/memos/new|GET|メモの新規登録画面表示|
|/memos/:id|GET|メモの詳細表示|
|/memos|POST|メモの登録|
|/memos/:id/edit|GET|メモの編集画面表示|
|/memos/:id|PATCH|メモの更新|
|/memos/:id|DELETE|メモの削除|

# 利用方法
## リポジトリのコピー

```
git clone git@github.com:udaikue/c-memo.git
```

`c-memo` ディレクトリに移動し Gem をインストールします。
```
cd c-memo
bundle
```

## データベースの準備
PostgreSQL に接続し、データベースを作成します。

```
CREATE DATABASE memo;
```
作成したデータベースに接続し、テーブルを作成します。

```
psql -d memo;
```

```
CREATE TABLE notes (
  id serial,
  title text NOT NULL,
  content text NOT NULL,
  PRIMARY KEY (id)
);
```

## 起動
```
bundle exec ruby memos.rb
```

ブラウザで以下にアクセスすると利用できます。

```
http://localhost:4567/memos
```
