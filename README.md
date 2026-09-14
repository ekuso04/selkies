# Selkies を使った Ubuntu エミュレーター

このワークスペースでは日本語向けに最適化をしています。
このワークスペースでは、[selkies-project/selkies](https://github.com/selkies-project/selkies) を使って、UbuntuのデスクトップをWebブラウザから操作できるエミュレーター環境を起動するためのCompose設定を作成しました。

## 概要

Selkiesは、Linuxデスクトップをブラウザ経由で表示し、操作できるようにするプロジェクトです。ここでは`ghcr.io/selkies-project/selkies/desktop:main-ubuntu26.04`の公開イメージを使い、UbuntuベースのLXQtデスクトップ環境をWebブラウザからアクセスできる形で起動します。

起動後は`http://localhost:8080`にアクセスすると、SelkiesのHTML5画面が表示されます。デフォルトのログインパスワードは`mypasswd`です。

## 必要要件

- Docker（Compose v2）
- ブラウザ（Chrome, Firefox, Edge など）

## 準備

Dockerの動作確認を行います。

```bash
docker --version
docker compose version
```

ワークスペースに置いてある`docker-compose.yml`を使います。

## 起動手順

1. イメージを取得します。

```bash
docker compose pull desktop
```

2. コンテナを起動します。

```bash
docker compose up -d desktop
```

3. ブラウザで開きます。

```text
http://localhost:8080
```

4. ログイン画面でユーザー名`ubuntu`パスワード`mypasswd`を入力します。

## パスワード変更

`docker-compose.yml`の`PASSWD`を変更したい場合は、次のように書き換えます。

```yaml
PASSWD: ${PASSWD:-your_password}
```

または`docker compose`実行前に環境変数を設定します。

```bash
export PASSWD=your_password
docker compose up -d desktop
```

## 停止手順

```bash
docker compose down
```

## 保存データのリセット

ユーザーのホームディレクトリ `/home/ubuntu` の保存内容を全部消して、コンテナを再起動したい場合は、ワークスペース直下のリセットスクリプトを使います。

```bash
./reset-selkies-data.sh
```

このスクリプトは、まず `docker compose down` で停止し、そのあと `selkies_selkies-home` ボリュームを削除して、最後に `docker compose up -d desktop` で新しいボリューム付きコンテナを起動します。これで保存済みデータや設定をすべて初期化できます。

## 注意事項

- `shm_size` はブラウザのレンダリング安定性のために`2gb`を指定しています。
- `SELKIES_MODE` はデフォルトで`websockets`です。
- ブラウザからのアクセス時は、ポート`8080`を使用します。

## 参考

- Selkies upstream: https://github.com/selkies-project/selkies
- Selkies documentation: https://docs.selkies.io/
