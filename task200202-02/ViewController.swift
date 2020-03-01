//
//  ViewController.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var convertedTextLabel: UILabel!
    
    var textFieldText = ""
    
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.convertedTextLabel.numberOfLines = 0
    }
    
    
    @IBAction func convertHiragana() {
        textFieldText = textField.text!
        print(textFieldText, textFieldText.utf8.count)
        
        self.api.convertHiragana(convertTextForApi: textFieldText) { (convertedStr) in
        guard let _convertedStr = convertedStr else {
              //コンバート失敗
              //アラートを出す
              return
          }
          DispatchQueue.main.async {
              self.convertedTextLabel.text = _convertedStr
          }
        }
    }
}
