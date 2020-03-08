# 前回提出で指定された課題  
  
## 必須  
  
- [x] テスト  
- [x] 表記ゆれや不必要な省略語  
- [ ] selfのキャプチャー  
- [x] completionでのResult型の利用  
- [x] deprecatedメソッドの利用  
- [ ] メソッドの切り出し  
- [x] Auto Layoutで制約つける  
  
## 任意  
  
- [x] `UITextView` の枠内をタップしたときに初期値を消去  
- [x] キーボードで結果がみれない  
    - 提出ボタンを押したらキーボードを隠すようにする    
- [x] textViewText.utf8.countは目的からするとisEmptyを使った方がよいかと  
    - utf8.countだとUTF-8で表した場合の単位数なので意味が異なります  
    - これは文字列が空かどうか調べる処理  
- [ ] エラー処理について  
    - API呼び出しなどの非同期処理はmanual propagation  
    - https://github.com/apple/swift/blob/master/docs/ErrorHandlingRationale.rst  
- [x] API トークンのもたせ方の見直し（現在：環境変数）  
- [x] `textViewText` はプロパティーとしての必要は特になかった  
- [ ] タスクのエラー処理も共通化は図られる  
