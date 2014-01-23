# ILC bot

なぜか毎週金曜日の夕方にILCとつぶやくbot。[@ILC_bot](http://twitter.com/ILC_bot)で稼働中。

# Getting started

以下インストール手順の例です。

```
$ git clone https://github.com/youcune/ILC-bot.git
$ cd ILC-bot
$ bundle install --path ./bundle/ --without test
$ mv ./config/config-example.yml ./config/config.yml
$ vim ./config/config.yml
  -> access_token など設定する
$ crontab -e
# 17:00に実行する例
# デフォルトではcrontabで起動する場合にPATHが通っていないので、PATHを通しておくかフルパスで書く
# ILC_bot.rbの引数は、./config/以下のymlファイルのファイル名と対応させてください
# これにより、ひとつ設置したら複数のトークンの組み合わせで実行できるようになります（誰得）
# こうしておくと（エラーはSTDERRに書かれるので）エラーの出た場合はcrontabがメールを送ってくれます
0 17 * * * BUNDLE_GEMFILE=/path/to/Gemfile bundle exec ruby /path/to/ILC_bot.rb config > /dev/null
```

# ToDo

* 月初はe-Attendanceと言うようにしたい
* 年末年始、GW、お盆にもうちょっと工夫したい

# Contributing

上記実装してプルリクください

# License

* Public Domain
* パクツイアフィアカウントのようなインターネットの癌になるような使い方はご遠慮ください
