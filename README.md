# go-jissen

[Go実践入門の7.6 Go Webサービスの作成](https://github.com/mushahiroyuki/gowebprog/tree/master/ch07/14web_service)の練習用リポジトリ。

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

3. APコンテナ内に入る
```bash
% make exec
```

4. バイナリファイル実行
```bash
(APコンテナ内)# build/14web_service
```

## DBコンテナでの事前確認

```bash
// ２つ目のプロンプトを立ち上げる
docker exec -it go-jissen_postgres_1 /bin/bash
(DBコンテナ内)# psql -U gwp -d gwp -c "select * from posts;"
 id | content | author 
----+---------+--------
(0 rows)
```

## 動作確認
```bash
// ３つ目のプロンプトを立ち上げる
% curl -i -X POST -H "Content-Type: application/json"  -d '{"content":"My first post","author":"Sau Sheong"}' http://127.0.0.1:8080/post/
HTTP/1.1 200 OK
Date: Fri, 13 Mar 2020 14:12:38 GMT
Content-Length: 0

```

## DBコンテナでの事後確認

```bash
// ２つ目のプロンプト
(DBコンテナ内)# psql -U gwp -d gwp -c "select * from posts;"
 id |    content    |   author   
----+---------------+------------
  1 | My first post | Sau Sheong
(1 row)
```

## コンテナ、イメージ削除
```bash
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
