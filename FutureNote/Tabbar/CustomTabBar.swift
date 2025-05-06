//
//  CustomTabBar.swift
//  FutureNote
//
//  Created by Other on 6/5/25.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    let centerButton = UIButton()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white.withAlphaComponent(0.1)

        centerButton.setImage(.iconCenterTabbar, for: .normal)
        centerButton.backgroundColor = .clear // hoặc đặt màu tùy ý

        if centerButton.superview == nil {
            addSubview(centerButton)
            centerButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(2)

                make.width.equalTo(54)
                make.height.equalTo(54)
            }
        }

        centerButton.layer.cornerRadius = centerButton.bounds.width / 2
        centerButton.clipsToBounds = true

        bringSubviewToFront(centerButton)
    }
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        customTabBar.centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func centerButtonTapped() {
        let storyboard = UIStoryboard(name: "AddNote", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "AddNoteViewController")
        self.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = self.viewControllers?.firstIndex(where: { $0 == viewController }) {
            let isDisableAction = index != 1
            return isDisableAction
        } else {
            return true
        }
    }
}
