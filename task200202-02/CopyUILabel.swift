//
//  CopyUILabel.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/03/03.
//  Copyright © 2020 tokizo. All rights reserved.
//

import UIKit

class CopyUILabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.copyInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.copyInit()
    }
    
    func copyInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(CopyUILabel.showMenu(sender:))))
    }
    
    @objc func showMenu(sender:AnyObject?) {
        self.becomeFirstResponder()
        
        let contextMenu = UIMenuController.shared
        contextMenu.showMenu(from: self, rect: self.bounds)
        
    }
    
    override func copy(_ sender: Any?) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = text
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}
