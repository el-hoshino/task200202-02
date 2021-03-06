//
//  ViewController.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var convertedTextLabel: UILabel!
    
    
    let hiraganaAPI = HiraganaAPI()
    var isFirstEditing: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 枠線
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        
        // 変換後テキストの文字列を折り返す
        self.convertedTextLabel.numberOfLines = 0
        
        textView.delegate = self
    }
    
    // returnキーでキーボードdismiss
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // UITextViewがタップされ、入力可能になる直前の処理
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(isFirstEditing){
            deleteTextViewText()
            isFirstEditing = false
        }
    }
    
    func displayAlert(alertTitle: String, alertMessage: String) {
        let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle:  UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteTextViewText() {
        textView.text = ""
    }
    
    @IBAction func convertHiragana() {
        // キーボードdismiss
        textView.resignFirstResponder()
        
        let textViewText = textView.text!
        let isStringEmpty: Bool = textViewText.isEmpty
        
        // 文字列が空のときにアラート
        if isStringEmpty {
            self.displayAlert(alertTitle: "空の文字列", alertMessage: "1文字以上の文字列を入力してください")
            return
        }
        
        self.hiraganaAPI.convert(convertText: textViewText) { (result) in
            switch result {
            case.success(let value):
                DispatchQueue.main.async {
                    self.convertedTextLabel.text = value
                }
            case.failure(let error):
                debugPrint(error)
                self.displayAlert(alertTitle: "変換失敗", alertMessage: "開発者にお問い合わせください")
                return
            }
        }
    }
}
