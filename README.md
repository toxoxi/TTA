TTA (Task Time Attack) - タスクをゲーミフィカルに進めるSlackBot  

# Feature
## MVP
- タスクとサブタスク、サブタスクの想定時間を受け取り、TTAがスタートする
- それぞれのサブタスクが終了したら :done: のリアクションをつけ、それにフックして時間を記録する
- 全てのサブタスクにdoneがついたら、レポートを出力する

## Further
- サブタスクの想定時間内に :done: がつかなかった場合、メンションを飛ばす
- これらの情報をtogglかなんかに飛ばす

# Architecture
- Lambda, API Gateway
  - Slackからイベントを受け取り、APIを叩く
- SQS
  - Slackは、イベントを送って3秒以内にレスポンスが無かった場合、リトライを行う仕様
  - 3秒以上の処理を行う可能性がある場合は、SQSを使いQueueing後に処理することでレスポンス自体は即座に返す
- DynamoDB
  - タスクの詳細、レポートの保存
- Serverless Framework(sls)
  - コンソールぽちぽちよりも、コードで管理したいよね

超参考になった記事
- https://www.kwbtblog.com/entry/2019/03/21/000001

# Todo
- [x] slsでデプロイして、lambdaが動作することを確認する
- [ ] SQSで処理できることを確認する
- [ ] slackとの繋ぎこみ
- [ ] タスク・サブタスクを任意の形式で受け取り、リアクションをフックして時間を記録して返す
- [ ] 全てのサブタスクに :done: がついたらレポートを出力する
