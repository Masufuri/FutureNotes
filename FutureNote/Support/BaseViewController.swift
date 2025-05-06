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
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = view.backgroundColor
    }
}


class BaseViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

