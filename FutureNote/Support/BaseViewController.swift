//
//  BaseViewController.swift
//  FutureNote
//
//  Created by Other on 5/5/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: Notification.Name("languageDidChange"), object: nil)
    }
    
    @objc func languageChanged() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


class BaseViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

