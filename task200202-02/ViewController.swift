//
//  ViewController.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var convertedTextLabel: UILabel!

    var textViewText = ""
    
    let hiraganaAPI = HiraganaAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 枠線
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        
        // 変換後テキストの文字列を折り返す
        self.convertedTextLabel.numberOfLines = 0
    }
    
    // 変換する文字列が空（文字数が0）の時のアラート
    func dispAlert(_ alertTitle: String, _ alertMessage: String) {
        let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            return
        })
        
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func convertHiragana() {
        textViewText = textView.text!
        let textLen: Int = textViewText.utf8.count
        
        if textLen == 0 {
            dispAlert("空の文字列", "1文字以上の文字列を入力してください")
            return
        }
        
        self.hiraganaAPI.convert(convertText: textViewText) { (convertedStr) in
        guard let _convertedStr = convertedStr else {
            self.dispAlert("変換失敗", "開発者にお問い合わせください")
              return
          }
          DispatchQueue.main.async {
              self.convertedTextLabel.text = _convertedStr
          }
        }
    }
}
