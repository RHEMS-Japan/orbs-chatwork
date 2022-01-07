# orbs-chatwork

[![CircleCI Build Status](https://circleci.com/gh/RHEMS-Japan/orbs-chatwork.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/RHEMS-Japan/orbs-chatwork) 

![badge](https://badges.rhems-japan.com/api-get-badge.svg?user_id=f3kRpRI20H4D6toMv0MX&timedelta=9&organization=RHEMS-Japan&repo=orbs-chatwork&app=orbs-chatwork&branch=alpha&cised=true&update=20220107-112657)

## Chatwork Orb For CircleCi

このorbは、CircleCiのpipelineコンフィグから、簡単にchatworkへメセージを送ることができるorbです。

This orb can easily send a message to chatwork from part of your CI / CD pipeline.

## Usage
### Get API Token

初めに、下記URLにアクセスし、ログインしたらAPI Tokenを発行して下さい。

First, access the URL below, log in, and issue an API Token.

https://www.chatwork.com/service/packages/chatwork/subpackages/api/token.php


<img src="images/for_readme/image01.png" width="300px">

### Set Environment Variables from CircleCi Project Settings

発行したAPI Tokenを、利用するCircleCi Projectの環境変数に`CHATWORK_TOKEN`という名前で登録して下さい。

Register the issued API Token in the environment variable of the CircleCi Project to be used with the name `CHATWORK_TOKEN`.

<img src="images/for_readme/image02.png" width="300px">



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
          room_id: "00000000"
          body: "hello"
```