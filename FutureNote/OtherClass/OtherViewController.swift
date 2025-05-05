//
//  OtherViewController.swift
//  FutureNote
//
//  Created by Other on 23/4/25.
//

import UIKit

protocol OtherDelegate: NSObject {
    func test()
}

class OtherViewController: UIViewController {
    
    var delegate: OtherDelegate?
    let name = "cuong"


    @IBAction func tappedAction() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5, execute: {
            print(self.delegate == nil)
        })
    }
    
    deinit {
        print("======= OtherViewController deinit=======")
    }
}
// ARC -> auto referend counting
// tránh leak memory
// weak => optional
// unowned => chắc chắn class không bị
