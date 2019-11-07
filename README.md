# README

この Hoiku-QandA アプリケーションは、作者が転職活動に向けて
作成したポートフォリオです。

このアプリケーションは質問投稿サイトで、主に保育所や学童保育に勤務する
保育士の方々が利用することを想定しています。

* Ruby version

2.6.3 またはそれ以降

* System dependencies

そのままHerokuで動作することを確認済みです。

* Configuration

Production設定ではそのままHerokuにデプロイできるようになっています。

* Database creation

Herokuではデプロイ時にPostgreSQLをインストールしておく必要があります。

$ heroku addons:add heroku-postgresql

* Database initialization

Production設定では、HerokuのデフォルトのRDBである
PostgreSQLが使用されます。PostgreSQL以外のRDBと
使用する際にはGemfileを更新してください。

$ heroku run bundle update

デプロイ後に1回、rails db:migration および rails db:seedコマンドを実行してください。

* How to run the test suite

部分的に、Rspecによるテストを実装しています。

* Services (job queues, cache servers, search engines, etc.)

現在はまだHerokuのローカルファイルシステム内に画像ファイル等を
保存する仕組みになっていますが、将来的にはアップロードされた
画像ファイルの置き場としてAmazon S3を利用するようにしたいと思います。
