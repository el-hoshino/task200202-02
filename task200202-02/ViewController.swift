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
    
    
    let hiraganaAPI = HiraganaAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 枠線
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        
        // 変換後テキストの文字列を折り返す
        self.convertedTextLabel.numberOfLines = 0
    }
    
    func displayAlert(alertTitle: String, alertMessage: String) {
        let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle:  UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteTextView() {
        textView.text = ""
    }
    
    @IBAction func convertHiragana() {
        let textViewText = textView.text!
        let isStringEmpty: Bool = textViewText.isEmpty
        
        // 文字列が空のときにアラート
        if isStringEmpty {
            self.displayAlert(alertTitle: "空の文字列", alertMessage: "1文字以上の文字列を入力してください")
            return
        }
        
        self.hiraganaAPI.convert(convertText: textViewText) { (convertedStr) in
            guard let _convertedStr = convertedStr else {
                // APIで変換に失敗したときにアラート
                self.displayAlert(alertTitle: "変換失敗", alertMessage: "開発者にお問い合わせください")
                return
            }
            DispatchQueue.main.async {
                self.convertedTextLabel.text = _convertedStr
            }
        }
    }
}
