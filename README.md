#  task200202-02  
  
## アプリ概要  
入力された文章を全てひらがなに変換するアプリ  
  
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
  
### 開発面  
- コミットメッセージにコミット内容別のプレフィックスをつけて、コミット内容を分かりやすくした。
    - 参考：[【今日からできる】コミットメッセージに 「プレフィックス」 をつけるだけで、開発効率が上がった話](https://qiita.com/numanomanu/items/45dd285b286a1f7280ed)
  
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
