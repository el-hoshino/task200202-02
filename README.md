#  task200202-02  
  
## アプリ概要  
入力された文章を全てひらがなに変換するアプリ  
  
## 所感  
2回目の提出です。([1回目提出branch](https://github.com/tokizuoh/task200202-02/tree/submission/20200303))  
1回目提出時に頂いたレビューを元に改善しました。  
"ボタン押下でアプリ強制終了"などのエラーに対しても、すぐに原因が探せるようになり若干の成長を感じます。  
  
## アクセストークンの設定  
`task200202-02`ディレクトリ直下に、下記の`AccessTokens.swift` を配置。 
  
```swift  
  let AccessToken = "gooラボにて取得したアプリケーションID"
```
  
[gooラボ](https://labs.goo.ne.jp/apiusage/)  
  
## 使い方  
1. ひらがなに変換したい文章をテキストフィールドに入力  
2. 「変換」ボタンを押下  
3. 「変換結果」の直下にひらがなに変換された文章が出力  
  
変換された文章を長押しでコピーすることができます。
  
## 開発環境  
- Xcode 11.3.1  
- Swift 5.1.3  
  
## 前回提出で指定されたタスク  

### 必須  

- [x] テスト  
  - [#24](https://github.com/tokizuoh/task200202-02/issues/24)  
  - 反省ポイントです。テストするにあたりUIの操作が必要でUITestを書きました。本来ならば、関数やメソッド単体でテストできるように設計する必要があると考えます。  
- [x] 表記ゆれや不必要な省略語  
  - [#16](https://github.com/tokizuoh/task200202-02/issues/16)  
- [ ] selfのキャプチャー  
- [x] completionでのResult型の利用  
  - [#22](https://github.com/tokizuoh/task200202-02/issues/22)  
- [x] deprecatedメソッドの利用  
  - [#26](https://github.com/tokizuoh/task200202-02/issues/26)  
- [ ] メソッドの切り出し  
- [x] Auto Layoutで制約つける  
  - [#18](https://github.com/tokizuoh/task200202-02/issues/18)  
  
### 任意  

- [x] `UITextView` の枠内をタップしたときに初期値を消去  
  - [#34](https://github.com/tokizuoh/task200202-02/issues/34), [#38](https://github.com/tokizuoh/task200202-02/issues/38)  
  - アプリ起動後、初めて `UITextView` を編集する際に文字列を空にする動作を取り入れました。これは、変換後に誤った文字列を指定してしまい、必ず文字列を全て削除する必要性は無いと考えたからです。もし文字列を全て削除したい場合には `UITextView` 直下の削除ボタンを押下すれば良いです。  
- [x] キーボードで結果がみれない  
  - [#32](https://github.com/tokizuoh/task200202-02/issues/32)  
  - 変換ボタン・入力後のリターンキー押下でキーボードを隠す処理を取り入れました。  
- [x] textViewText.utf8.countは目的からするとisEmptyを使った方がよいかと  
  - [こちら](https://github.com/tokizuoh/task200202-02/commit/63afb15425391ab664d500e884cf11a6fb6d0b33)にて対応。  
- [ ] エラー処理について  
  - API呼び出しなどの非同期処理はmanual propagation  
  - https://github.com/apple/swift/blob/master/docs/ErrorHandlingRationale.rst  
- [x] API トークンのもたせ方の見直し（現在：環境変数）  
  - [こちら](https://github.com/tokizuoh/task200202-02/commit/a59a7f90a686508cee30f72873c5b05f717b6926)で対応。  
- [x] `textViewText` はプロパティーとしての必要は特になかった  
  - [こちら](https://github.com/tokizuoh/task200202-02/commit/d50f20380ec52e52a1137b1e938f34fb6f98b93e)で対応。    
- [ ] タスクのエラー処理も共通化は図られる  
