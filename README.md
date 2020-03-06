# go-jissen

[Go実践入門のchitchat](https://github.com/mushahiroyuki/gowebprog/tree/master/ch02/chitchat)の練習用リポジトリ。

## 動作環境

* docker-compose
  * go: 13.7 buster
  * postgres: latest
    * データ永続化はしていない
    * 設定は特にしていない


## 起動方法メモ

下記の手順をすれば、特にGoやDBの設定をしなくても起動することを確認している。
`make`コマンドが使えない場合は、`Makefile`内のコマンドを参照。

1. イメージビルド&コンテナ作成
```bash
% make create
```

2. Goモジュールのビルド
```bash
% make build
```

3. コンテナ内に入る
```bash
% make exec
```

4. バイナリファイル実行
```bash
(コンテナ内)$ build/chitchat
```

5. localhost:8080 にアクセス

## コンテナ、イメージ削除

```
% make destroy
```

## 書籍サンプルとの変更点

### Go側のDB接続設定

`/chitchat/data/data.go`のDBへの接続(`sql.Open`)をdocker-compose用に変更

```go
connectTemplate := "host=%s port=%s user=%s password=%s dbname=%s sslmode=disable"
// DBHost is db-container name
DBHost := os.Getenv("DB_HOST")
// DBUser is name
DBUser := os.Getenv("DB_USER")
// DBPass is password
DBPass := os.Getenv("DB_PASS")
// DBPort is connection type
DBPort := os.Getenv("DB_PORT")
// DBName is DB name
DBName := os.Getenv("DB_NAME")

connect := fmt.Sprintf(connectTemplate, DBHost, DBPort, DBUser, DBPass, DBName)

Db, err = sql.Open("postgres", connect)
```

### DBの初期投入クエリ

初回DBコンテナ作成時に、テーブルがドロップできずエラーとなるため、以下を実施した。

* `/chitchat/data/setup.sql`を`/docker/postgres/init/*`にコピー
* `drop`文を以下に変更

```diff
- drop table posts;
- drop table threads;
- drop table sessions;
- drop table users;
+ drop table if exists posts;
+ drop table if exists threads;
+ drop table if exists sessions;
+ drop table if exists users;
```