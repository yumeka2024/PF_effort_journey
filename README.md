# effort journey

## サイト概要

### サイトテーマ

頑張りを記録、シェアして仲間を見つける、

あなたの成長を共に歩む場所になる、SNSコミュニティサイト

### テーマを選んだ理由

私は、社会人として業務を進める中で、「時間の使い方」は、その後の自分の成長に直結する、とても重要なことだと痛感しました。
仕事以外の時間には、自己学習や体調管理のための運動、更には家事やリラックスする時間など、多岐にわたる活動があります。
これらを効率的に行うためには、まず自分が「何にどの程度の時間を費やしているか」を明確に把握することが不可欠だと考えました。
そのため、ワンクリックで作業の開始と終了時間を記録し、どんな活動も簡単に記録できるシンプルで柔軟性のあるサービスを求めていました。

近年では、リスキリングの重要性が強調され、社会的にも自己学習が推奨されていると感じます。
リスキリングのために自己学習に励む方が直面する課題として、以下のようなものが挙げられます。

「時間が不足している」「成長の実感が得られない」「モチベーションが続かない」

また、コロナ禍で運動不足となった人も多く、健康増進のため定期的な運動に励む方が直面する課題も同様です。
これらの課題を解決するため、私は次のようなアプローチを取りました。

「活動時間の可視化とタイムマネジメントの実現」「活動記録の振り返りと共有」「コミュニティ形成」

これらの機能を備えたサービスを開発することで、利用者がより効果的に自己成長に取り組める環境を提供することを目指しました。

### ターゲットユーザ

- 昇進や転職などの目標に向けて自己学習に励む人
- 健康増進などの目標に向けて運動に励む人
- 学習、運動、趣味など、多様な活動時間を記録・管理したい人
- 日々の振り返りを通じて自己成長を意識し、更に成長したい人
- タイムマネジメントを実現し、効率的に時間を活用したい人
- 仲間との共有を通じて励まし合いや刺激を受け、モチベーションを維持したい人

### 主な利用シーン

- 自己学習した時間を記録したいとき
- 運動に費やした時間を記録したいとき
- 趣味や読書、家事などに費やした時間を記録したいとき
- 学習や運動などの活動を振り返り、改善していきたいとき
- 仲間との交流を通じてモチベーションを高めたいとき

## 設計書

### ER図
![effort_journey_ER図ver2](https://github.com/yumeka2024/PF_effort_journey/assets/154503350/6f8e24ee-d732-41b9-894b-bb72ca5ce648)

### 画面遷移図
![effort_journey_UIFlowsver2](https://github.com/yumeka2024/PF_effort_journey/assets/154503350/dd186062-0427-498a-80c8-73022e5fbf37)

### テーブル定義書
https://docs.google.com/spreadsheets/d/1b-snL9J43WG0Ow1AD9XCV6rVFgQCxou7aTKOE-XFA3A/edit?usp=sharing

### 実装機能一覧
- ユーザー認証機能(devise、ID以外のカラムでのルーティング、公開/非公開設定)
- 管理者機能(devise)
- 画像アップロード機能(Active Storage)
- ホーム機能(無限スクロール化、NotFoundビュー、アラートの表示/自動非表示機能)
- 投稿機能(CRUD機能)
- コメント機能(CRUD機能)
- いいね機能(非同期通信(Ajax))
- 閲覧数カウント機能
- フォロー機能(非同期通信(Ajax)、リクエスト承認機能)
- 検索機能(非同期通信(Ajax)、複数テーブル検索)
- 活動記録機能(CRUD機能、ラベル機能、打刻機能、打刻編集ログ保存機能、絞り込み一覧表示機能)
- 通知機能(非同期通信(Ajax)、一覧表示時の既読処理、通知対象削除時の情報保持機能)
- AIによるスコアリング機能(Google Natural Language API、アドバイス生成機能)
- おすすめタイムライン生成機能(投稿日時/スコアを元にユーザーに合わせた投稿をランダム表示する機能)
- メール送信機能(Action Mailer)

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用技術

[![](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=flat&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![](https://img.shields.io/badge/HTML-1572B6?style=flat&logo=html5&logoColor=white&color=orange)](https://example.com)
[![](https://img.shields.io/badge/CSS-1572B6?style=flat&logo=css3&logoColor=white)](https://www.w3.org/Style/CSS/Overview.en.html)
[![](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![](https://img.shields.io/badge/Bootstrap-563D7C?style=flat&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/)
[![](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)](https://git-scm.com/)
[![](https://img.shields.io/badge/Amazon_AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![](https://img.shields.io/badge/Amazon_EC2-232F3E?style=flat&logo=amazon-ec2&logoColor=white)](https://aws.amazon.com/ec2/)
[![](https://img.shields.io/badge/Amazon_RDS-232F3E?style=flat&logo=amazon-rds&logoColor=white)](https://aws.amazon.com/rds/)
[![](https://img.shields.io/badge/Nginx-009639?style=flat&logo=nginx&logoColor=white)](https://nginx.org/)
[![](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)](https://www.mysql.com/)

<!--## 使用素材-->
<!--使用検討中です-->
