#  task200202-02  
  
## アプリ概要  
入力された文章を全てひらがなに変換するアプリ  
  
## 所感  
Xcodeを扱うのがほぼ初めてで、慣れるまでに時間がかかりました。  
Xcodeに慣れる時間と機能追加に大半の時間を割いたので、テストや設計まで着手できなかったのが反省です。  
  
また、Swiftをまともに扱うのは今回が初めてで、Optional型などのSwift特有の安全な言語思想に慣れるまでに時間がかかりました。  
  
下記の「工夫した点」にも記載しましたが、自分が知っている技術を取り入れました。  
  
今回はiOSアプリ開発について期間を設けて勉強するのは初めてで、自分の開発の幅が広がりとても楽しかったです。  
エラーハンドリングの適切な場所などがよく分かっていないので、これからも手を動かして学んでいきたいです。  
  
## 環境変数の設定  
  
|key  |value  |
|:--|:--|  
|GOO_API_KEY|[gooラボ](https://labs.goo.ne.jp/apiusage/)にて取得したアプリケーションID|  
  
## 使い方  
1. ひらがなに変換したい文章をテキストフィールドに入力  
2. 「変換」ボタンを押下  
3. 「変換結果」の直下にひらがなに変換された文章が出力  
    
## 開発環境  
- Xcode 11.3.1  
- Swift 5.1.3  
  
## 工夫した点  
  
### 実装面  
- 空の文字列をAPIに渡す前に検知させた。  
    - 空の文字列をAPIに渡すと `server error` になるので、エラーが出ると分かっているものはAPIに渡さずに検知したほうが良いと考えたため。  
- 入力を `textView` にし、複数行でも見やすくした。  
    - `textField`だと自動で改行されず、一行のみで表示される。  
- APIキー（今回でいうところのgooラボappID）の管理を環境変数にした。  
    - [iOSアプリ内にAPIアクセスキーを保持するベストプラクティス(Swift)](https://qiita.com/uhooi/items/c3fd487f2ba6cd1990af) では、`.swift `に直書きして `.gitignore` に入れると記載されているが、大規模開発になった際の `.gitignore` 記述忘れをい考慮して環境変数での管理を選んだ。  
  
### 開発面  
- コミットメッセージにコミット内容別のプレフィックスをつけて、コミット内容を分かりやすくした。
    - 参考：[【今日からできる】コミットメッセージに 「プレフィックス」 をつけるだけで、開発効率が上がった話](https://qiita.com/numanomanu/items/45dd285b286a1f7280ed)  
- ブランチの命名規則  
    - `feature\{issue番号}`  
  
## 悩み  
- APIから受け取ったレスポンスから、エラーの際の細かいメッセージを取得したかったができなかった。　　（`HiraganaApi.swift`）  
    - 下記を試した結果、全て "bad request" と出力された。  
        - 存在しない `appID`  
        - 存在しない `outputType`  
        - `Content-Type` が空  
    - 参考：[gooラボ：APIのエラーレスポンスについて](https://labs.goo.ne.jp/api_error_info/)  
  
```swift
if !((200...299).contains(response.statusCode)) {
    let errorMessage: String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    debugPrint("\(response.statusCode): \(errorMessage)")
    completion?(nil)
    return
}
```
  
→ 「`Invalid app_id`」などを取得したかった。  
  
- 内部エラーをユーザーにどのように伝えるかが分からない。  
    - API周りのエラーをアラートで伝えるか、UILabelのみで伝えるか、など。  
  
- エラーハンドリングをどこで行うのがベストなのか分からない。  
    - 例えば、関数の呼ぶ方、呼ばれる方  
        - 関数の呼ぶ方：関数の戻り値でエラーハンドリング  
        - 関数の呼ばれる方：エラーメッセージを出力して強制終了  
  
## 改善点  
- MVC/MVP/MVVM/Redux による適切な設計  
    - どの言語でもこういった設計を実装に落とし込んだことがないので次回提出時にチャレンジします。  
- gitの運用 (READMEなどのドキュメント整備は単独でブランチ切るか？など)  
- テストの導入 
    - [やさしいSwift単体テスト 〜テスト可能なクラス設計・前編〜](https://qiita.com/yokoyas000/items/b00012c8b1a84238becf) こちらを現在読んでいます。  
- 複数デバイスに対応するレイアウト構築  
    - iPhone 11 Pro Maxでレイアウトを作成していましたが、iPhone8などの他サイズのデバイスでレイアウトが崩れます。これは各UI要素の位置を絶対位置で置いているからだと考えます。  
  
## 参考にしたサイト  
  - [【Xcode】ひらがな化APIを使ったアプリを作りました【Swift】](https://qiita.com/haruusagi/items/9da1ca30f56487f21801)  
      - おそらく同じ課題を受けた方だと思われる。この方のコードに加え、エラーメッセージの詳細表示などのリファクタリングを行った。  
- [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)  
    - ブランチの命名規則について  
