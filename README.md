# orbs-chatwork

[![CircleCI Build Status](https://circleci.com/gh/RHEMS-Japan/orbs-chatwork.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/RHEMS-Japan/orbs-chatwork) 

![badge](https://badges.rhems-japan.com/api-get-badge.svg?user_id=f3kRpRI20H4D6toMv0MX&timedelta=9&organization=RHEMS-Japan&repo=orbs-chatwork&app=orbs-chatwork&branch=main&cised=true&update=20220111-160915)

## Chatwork Orb For CircleCi

このorbは、CircleCiのpipelineコンフィグから、簡単にchatworkへメセージを送ることができるorbです。

This orb can easily send a message to chatwork from part of your CI / CD pipeline.

## Usage
### Get API Token

初めに、下記URLにアクセスし、ログインしたらAPI Tokenを発行して下さい。

First, access the URL below, log in, and issue an API Token.

https://www.chatwork.com/service/packages/chatwork/subpackages/api/token.php


<img src="images/for_readme/image01.png" width="600px">

### Set Environment Variables from CircleCi Project Settings

発行したAPI Tokenを、利用するCircleCi Projectの環境変数に`CHATWORK_TOKEN`という名前で登録して下さい。

Register the issued API Token in the environment variable of the CircleCi Project to be used with the name `CHATWORK_TOKEN`.

<img src="images/for_readme/image02.png" width="600px">

### How to write `.circleci/config.yml`

chatworkのroom idをURLから確認します。以下の場合、room idは`123456789`となります。

Check the chatwork room id from the URL. In the following cases, the room id is `123456789`.

```
https://www.chatwork.com/#!rid123456789
```

下記は、指定したroom idに`hello`と送る例です。

The following is an example of sending `hello` to the specified room id.

```yml
version: 2.1

orbs:
  rj-chatwork: rhems-japan/chatwork@a.b.c

jobs:
  something-job:
    docker:
      - image: cimg/base:stable
    steps:
      - checkout
      - rj-chatwork/chatwork-send:
          room_id: "123456789"
          body: hello
```

### What if you want to send an image?

chatworkに送るメッセージに画像を利用したい場合は、事前に準備が必要です。
利用するroom idのチャンネルに、画像をアップロードしておきます。
例えば、当リポジトリに用意した`images/success.png`を利用して説明します。

If you want to use images in messages sent to chatwork, you need to prepare in advance.
Upload the image to the channel of the room id you use.
For example, we will explain using `images/success.png` prepared in this repository.

<img src="images/success.png" width="100px">

画像をチャンネルにアップロードした後、編集を選択します。

After uploading the image to the channel, select Edit.

<img src="images/for_readme/image03.png" width="600px">
<img src="images/for_readme/image03e.png" width="600px">

`preview id`を確認し、控えておきます。

Check the `preview id` and make a note of it.

<img src="images/for_readme/image04.png" width="600px">
<img src="images/for_readme/image04e.png" width="600px">

parameters.bodyに、`preview id`を指定し、htには画像サイズを指定して下記のように記載します。

Specify `preview id` in parameters.body, specify the image size in ht, and describe as follows.

```yml
body: "[preview id=866484042 ht=60]"
```

全体的には下記のような`config.yml`になります。

The entire `config.yml` is described as follows.

```yml
version: 2.1

orbs:
  rj-chatwork: rhems-japan/chatwork@a.b.c

jobs:
  something-job:
    docker:
      - image: cimg/base:stable
    steps:
      - checkout
      - rj-chatwork/chatwork-send:
          room_id: "123456789"
          body: "[preview id=866484042 ht=60]"
```

### How to send a multi-line message with an image?

複数行で文字列を送信したい場合、方法はいくつかあるかとは思いますが、ここではコマンド`chatwork-send`を呼ぶ前に、スクリプトを書いて前処理を行う方法を紹介します。
例えば、下記のように記述すると実現できます。

If you want to send a string on multiple lines, there may be several ways to do it, but here's how to write a script to do the pre-processing before calling the command `chatwork-send`.
For example, it can be realized by writing as follows.


```yml
version: 2.1

orbs:
  rj-chatwork: rhems-japan/chatwork@a.b.c

jobs:
  something-job:
    docker:
      - image: cimg/base:stable
    steps:
      - checkout
      - run:
          name: create message
          command: |
            MESSAGE=$(cat \<<EOF
            Branch : $CIRCLE_BRANCH
            Time : $(date "+%Y/%m/%d %H:%M:%S")
            https://circleci.com/workflow-run/${CIRCLE_WORKFLOW_ID}
            EOF
            )
            BODY="[preview id=866484042 ht=60][hr]${MESSAGE}"
            echo "export MESSAGE='${BODY}'" >> $BASH_ENV
      - rj-chatwork/chatwork-send:
          room_id: "255694560"
          body: $MESSAGE
```

実行結果は下記のとおりです。
複数行のメッセージと画像を組み合わせることが出来ており、[定義済み環境変数](https://circleci.com/docs/ja/2.0/env-vars/#built-in-environment-variables)と組み合わせてCircleCiのワークフローを確認しやすくしています。

The execution result is as follows.
You can combine multi-line messages and images, and combine them with [Built-in environment variables](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables) to make it easier to see your CircleCi workflow.

<img src="images/for_readme/image05.png" width="600px">

## Description of other configurable parameters

|param|type|description|default|
|:---:|:---:|:---|:---|
|`api_ver`|string|Chatwork API's version|`"v2"`|
|`token`|env_var_name|Chatwork API's Token|-|
|`room_id`|string|Chatwork Room ID|-|
|`body`|string|The contents of the body sent to Chatwork|-|
|`self_unread`|boolean|Whether Token users should unread messages or not. <br>Unread=`true`, Read=`false`|`true`|
|`when`|enum|[when attribute](https://circleci.com/docs/2.0/configuration-reference/#the-when-attribute).<br>`on_success`:the step will run only if all of the previous steps have been successful (returned exit code 0).<br>`always`:the step will run regardless of the exit status of previous steps.<br>`on_fail`: the step will run only if one of the preceding steps has failed (returns a non-zero exit code).|`on_success`|

