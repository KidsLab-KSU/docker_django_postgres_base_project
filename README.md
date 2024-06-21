# Djangoのサンプルアプリケーション

## 変更が必要な箇所

### 各ファイルの"your_app_name"の部分を自分のアプリケーション名に変更する

- .env/.env.dev, .env.prod
- config/urls.py 
- postgres/init/init.sql
- dcoker-compose.dev.yml, docker-compose.prod.yml
- config/settings.py
- your_app_name/apps.py

## 起動/終了方法

### 開発環境（起動）

```bash
    docker-compose -f docker-compose.dev.yml up -d　//コンテナを立ち上げる
    docker exec -it your_app_name bash              //コンテナの中に入る
    python manage.py runserver 0.0.0.0:80           //コンテナの中で実行。-v オプションでdbのデータが入ったボリュームを削除しながら終了する。
```

### 開発環境（終了）

```bash
    docker-compose -f docker-compose.dev.yml down //コンテナの外で実行
```

## サーバー（本番環境）に上げる時

### 事前に開発環境でやること(データベース内のデータの出力)

```bash
    python manage.py --format=yaml dumpdata > your_app_name_db_data.yaml //コンテナの中で実行
```

### 本番環境でやること

```bash
    docker-compose -f docker-compose.prod.yml up -d　//コンテナを立ち上げる
    docker exec -it your_app_name bash                 //コンテナの中に入る
    python manage.py loaddata --format=yaml your_app_name_db_data.yaml //データベースのデータを読み込む
```

### postgresql上級者へ

以下のコマンドは、ローカルのデータをダンプして同名のデータベースにリストアすることと同義です。

```bash
    python manage.py --format=yaml dumpdata > your_app_name_db_data.yaml //コンテナの中で実行
    python manage.py loaddata --format=yaml your_app_name_db_data.yaml //データベースのデータを読み込む
```

### 終了

```bash
    docker exec -it your_app_name bash                 //コンテナの中に入る
    python manage.py --format=yaml dumpdata > your_app_name_db_data.yaml //念のためデータベースのデータを出力しておく
    docker-compose -f docker-compose.prod.yml down //コンテナの外で実行。-v オプションでdbのデータが入ったボリュームを削除しながら終了する。
```


### SQLをdjangoを介さずに使うライブラリpsycopg2を使ってアプリを作っている場合（例；PositiveMoodPlaylist）

- .env/.env.dev, .env/.env.prod　以下のようなpostgresqlとの接続情報の記載が必要。
  - アプリ名がsampleの場合：DATABASE_SAMPLE_URL=postgres://postgres:pos.pos..pos@sample_db:5432/sample
  - アプリ名がpositive_mood_playlistの場合：DATABASE_POSITIVE_MOOD_PLAYLIST_URL=postgres://postgres:pos.pos..pos@positive_mood_playlist_db:5432/positive_mood_playlist
