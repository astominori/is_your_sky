# *IS YOUR SKY* - 誰かのみた空を覗いてみるSNS -

<br>
Rails 学習で作成したwebアプリケーションです。<br>
現在作成途中のため、適宜更新していきます。<br>
<br>

## Overview

![スクリーンショット 2020-10-06 20 00 16](https://user-images.githubusercontent.com/37829128/95193316-98bcb380-080e-11eb-8a6e-30100aea1dd4.png)

is your sky は空の写真を投稿し、シェアするSNSです。
  
  
ユーザは、空の写真と共にタイトル、文章、タグをつけて投稿ができます。 <br>
他の人が投稿した空の写真を検索し、見ることもできます。
<br>
<br>

## APP URL

<br>
https://isyoursky-web.herokuapp.com/
<br>

## DEMO USER

<br>
各種登録機能は実装済みですが、<br>
デモユーザーでログイン可能です。
<br>
MAIL：example-1@mail.com<br>
PASS：password
<br>
<br>

## VERSION

<br>

```
Ruby 2.4.5
Ruby on Rails 5.2.2

```

<br>

## FUNCTION

<br>
以下の機能を実装しています

 * 会員登録機能
 * 登録編集機能（パスワード変更）
 * SNS認証機能(Facebook、Twitter）
 * ログイン・ログアウト機能
 * 投稿機能（投稿・更新・削除）
 * 画像プレビュー機能
 * タグ機能（付与・更新・削除）
 * 投稿検索機能（タグ・日付）

今後実装予定の機能

* 画像解析（Vision API）
   - ラベリングによる自動タグ付け
   - 解析結果による空の写真以外の投稿禁止
* 空の色合いによるカテゴライズ化（Rmagick）
* Google Map連携（Google Map API）
   - 地域ごとに空の写真を地図上にマッピング
   - 各地域の今日の空を地図上に可視化
 
<br>

## Why "IS YOUR SKY" ?

<br>
このWebサービスを作ろうと思った背景には、「誰にとっても心癒されるSNSを作りたい」という思いがありました。<br>

今年はコロナの影響もあり、多くの人が「自分がやりたいことができないもどかしさ」や「先の見えない漠然とした不安」を抱えています。 <br>
私自身もそうでした。旅行に行ったり、友達に会うという"当たり前"が難しく、家に籠もりっきり。なんとなく気分が沈みがちな日々。 <br>
SNSを見ても、いろんな人が具体的に言葉にせずとも「焦り」や「不安」を抱えていて、余裕のない感じがしました。 <br>

そんな中、私はこの沈みがちな日常に、小さな幸せを発見しました。それは、「空の写真をとること」 <br>
散歩中や、ふと窓の外を見た時、またはドライブ中。綺麗な空を見つけては写真をパシャリと取りました。 <br>
何枚か撮りためたあと、なにもあげる写真がなかったSNSにその空たちをあげると、想像以上に友人たちから反応がありました。<br> 

<br>
そこで、ふと思ったのです。**「空っていいな」**<br>
考えてみれば、空は、表情は移りゆくけれど、誰にとってもとても身近なものです。<br>

友達に会えない、ライブにいけない、旅行にいけない、ないない尽くしのコロナ禍の中でも「誰にでもあるもの」<br>
スマホを持って外やベランダに出て、空を眺める。それだけで自分はとても幸せでした。さらに、その写真を見た人たちも幸せになれる。<br>
この「空をみる」という行為は、誰にとっても平等で、心を落ち着かせたり、癒してくれるものなんじゃないか。<br>
それこそが、今の時代に必要なものなのでは、と思いました。<br>
<br>

そんなアイデアから、IS YOUR SKYを作り始めました。<br>
SNS形式にしたのは、「自分で撮影した空を共有する」、「他の人がみた空をみる」という両方を実現するためです。<br>

「is your sky (...はあなたの空)」という名前にしたのは、自分が投稿した「空」も、誰かが投稿した「空」も<br>
平等にだれのものでもない、「あなたがみた空」である。という意味を持せたかったからです。<br>

<br>
自分が撮影した空の写真を見返したり、誰かがその日みた空を見てみる。<br>
それによって、少しでも心が癒されたり、ホッとできたらいいなと思っています。<br>
<br>


