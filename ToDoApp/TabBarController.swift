//
//  TabBarController.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/15/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        stylize()
    }

}

extension TabBarController: Stylized {
    func stylize() {
        let styleViewModel = StyleViewModel()
        guard let style = styleViewModel.style(at: StyleViewModel.defaultStyleIndex) else { return }
        
        let navigationBarFont = UIFont(name: style.navigationBar.fontName, size: CGFloat(style.navigationBar.fontSize))
        let navigationBarColor = UIColor.fromHEX(hex: style.navigationBar.tintColor)
        
        navigationController?.navigationBar.tintColor = navigationBarColor
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : navigationBarColor,
            NSAttributedStringKey.font : navigationBarFont as Any
        ]
        
        tabBar.tintColor = UIColor.fromHEX(hex: style.tabBar.tintColor)
    }
}
