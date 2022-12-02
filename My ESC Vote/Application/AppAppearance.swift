//
//  AppAppearance.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 25/11/2022.
//

import Foundation
import UIKit

final class AppAppearance {
	
	static func setupAppearance() {
		navigationBarAppearance()
		tabBarAppearance()
		buttonAppearance()
	}
	
	static private func navigationBarAppearance() {
		UINavigationBar.appearance().titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: Color.Primary.accentColor
		]
	}
	
	static private func tabBarAppearance() {
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.Primary.accentColor], for: .selected)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.Primary.dimmedAccentColor], for: .normal)
	}
	
	static private func buttonAppearance() {
		UIButton.appearance().titleLabel?.font = UIFont(name: Font.Name.metropolisThin, size: 10)
	}
}
