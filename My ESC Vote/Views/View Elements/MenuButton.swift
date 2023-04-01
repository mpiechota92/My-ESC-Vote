//
//  MenuButton.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 05/11/2022.
//

import UIKit

class MenuButton: UIButton {
	
	
	private weak var registrationViewController: Dismissable!
	private weak var loginViewController: Dismissable!
	
	weak var parent: UIViewController!
	
	weak private var navigationController: UINavigationController?
	
	weak private var storyboard: UIStoryboard?
	
	private lazy var menuItems: [String: UIMenuElement] = [
		"register": UIAction(title: "Register", image: UIImage(systemName: Icon.register), handler: handleRegisterMenu),
		"login": UIAction(title: "Login", image: UIImage(systemName: Icon.login), handler: handleLoginMenu),
		"logout": UIAction(title: "Logout", image: UIImage(systemName: Icon.logout), handler: handleLogoutMenu),
		"settings": UIAction(title: "Settings", image: UIImage(systemName: Icon.settings), handler: handleSettingsMenu)
	]
	
	private lazy var aboutSubMenu: UIMenu = UIMenu(title: "",
												   options: .displayInline,
												   children: [UIAction(title: "About", image: UIImage(systemName: Icon.about), handler: handleAboutInfoMenu)])
	
	private lazy var isLoggedin: Bool! = false {
		willSet {
			var items: [UIMenuElement]
			if newValue {
				items = [menuItems["logout"]!, aboutSubMenu]
				
			} else {
				items = [menuItems["login"]!, menuItems["register"]!, aboutSubMenu]
			}
			
			self.menu = UIMenu(title: "", children: items)
		}
	}
	
	func setupButton(for navigationController: UINavigationController?, with storyboard: UIStoryboard?) {
		
		self.navigationController = navigationController
		self.storyboard = storyboard
		
		self.showsMenuAsPrimaryAction = true
		self.overrideUserInterfaceStyle = .dark
		self.tintColor = Color.tintColor
		self.setImage(UIImage(systemName: Icon.user), for: .normal)
		
		isLoggedin = APIManager.shared().authService.isLoggedIn()
		
		NotificationCenter.default.addObserver(forName: .onLoginStatusChangeNotification, object: nil, queue: .main) { notification in
			self.isLoggedin = APIManager.shared().authService.isLoggedIn()
		}
	}
	
	@objc private func handleRegisterMenu(_ action: UIAction) {
		let registrationVC = RegisterViewController.instantiateViewController()
		registrationVC.dismissableDelegate = self
		registrationVC.setupDismissableView(parent)
		registrationVC.showView()
	}
	
	@objc private func handleLoginMenu(_ action: UIAction) {
		let loginVC = LoginViewController.instantiateViewController()
		loginVC.dismissableDelegate = self
		loginVC.setupDismissableView(parent)
		loginVC.showView()
	}
	
	@objc private func handleLogoutMenu(_ action: UIAction) {
		guard APIManager.shared().authService.isLoggedIn() else { return }
		
		APIManager.shared().authService.logOut { error in
			if let error = error {
				print(error.localizedDescription)
			}
		}
	}
	
	@objc private func handleSettingsMenu(_ action: UIAction) {
		
	}
	
	@objc private func handleAboutInfoMenu(_ action: UIAction) {
		
	}
	
}

// MARK: - Dismissable Views

extension MenuButton {
	
	func setupMenuButton() {
		setupLogin()
	}
	
	private func setupRegistrationView() {
		self.registrationViewController = RegisterViewController.instantiateViewController()
		self.registrationViewController.setupDismissableView(parent)
		
	}
	
	private func setupLogin() {
		self.loginViewController = LoginViewController.instantiateViewController()
		self.loginViewController.setupDismissableView(parent)
	}
}

// MARK: - DismissableDelegate

extension MenuButton: DismissableDelegate {
	
	func willAppear() {
		self.isEnabled = false
	}
	
	func willDismiss() {
		self.isEnabled = true
	}
	
}
