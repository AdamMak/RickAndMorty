//
//  Theme.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

struct Theme {
    static func applyTheme() {
        styleNavigationBar()
    }
    
    static func styleNavigationBar() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isOpaque = false
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = true
    }
}
