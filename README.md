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


