//
//  ViewController.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textFieldText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func conbertHiragana() {
        textFieldText = textField.text!
        print(textFieldText)
    }


}

