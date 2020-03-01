#  task200202-02  
  
## アプリ概要  
入力された文章を全てひらがなに変換するアプリ  
  
## 使い方  
1. ひらがなに変換したい文章をテキストフィールドに入力  
2. 「変換」ボタンを押下  
3. 「変換結果」の直下にひらがなに変換された文章が出力  
    
## 工夫した点  
  
### 実装面  
- 空の文字列をAPIに渡す前に検知させた。  
    - 空の文字列をAPIに渡すと `server error` になるので、エラーが出ると分かっているものはAPIに渡さずに検知したほうが良いと考えたため。  
  
### 開発面  
- コミットメッセージにプレフィックスをつけてコミットを分かりやすくした。
    - [【今日からできる】コミットメッセージに 「プレフィックス」 をつけるだけで、開発効率が上がった話](https://qiita.com/numanomanu/items/45dd285b286a1f7280ed)
