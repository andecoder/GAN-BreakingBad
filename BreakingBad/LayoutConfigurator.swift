//
//  LayoutConfigurator.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

// Couldn't find a way to unit test this :(
enum LayoutConfigurator {

    static func applyLayoutAppearance() {
        applyNavBarAppearance()
        applySearchBarAppearance()
    }

    private static func applyNavBarAppearance() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.isTranslucent = true
    }

    private static func applySearchBarAppearance() {
        let searchTextFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextFieldAppearance.defaultTextAttributes = [.foregroundColor: UIColor.white]
        searchTextFieldAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        let placeholderColor = UIColor(red: 142 / 255.0, green: 142 / 255.0, blue: 147 / 255.0, alpha: 1.0)
        searchTextFieldAppearance.attributedPlaceholder = NSAttributedString(string: "Character's name",
                                                                             attributes: [.foregroundColor: placeholderColor])
    }
}
