//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController {
	
	typealias Icon = Constants.Design.Image.Icon
	
	@IBOutlet weak var userButton: UIButton!
	
	private lazy var isLoggedin: Bool! = false {
		willSet {
			var items: [UIMenuElement]
			if newValue {
				items = [menuItems["logout"]!, aboutSubMenu]
				
			} else {
				items = [menuItems["login"]!, menuItems["register"]!, aboutSubMenu]
			}
			
			userButton.menu = UIMenu(title: "", children: items)
		}
	}
	
	private lazy var menuItems: [String: UIMenuElement] = [
		"register": UIAction(title: "Register", image: UIImage(systemName: Icon.register), handler: handleRegisterMenu),
		"login": UIAction(title: "Login", image: UIImage(systemName: Icon.login), handler: handleLoginMenu),
		"logout": UIAction(title: "Logout", image: UIImage(systemName: Icon.logout), handler: handleLogoutMenu),
		"settings": UIAction(title: "Settings", image: UIImage(systemName: Icon.settings), handler: handleSettingsMenu)
	]
	
	private lazy var aboutSubMenu: UIMenu = UIMenu(title: "",
												   options: .displayInline,
												   children: [UIAction(title: "About", image: UIImage(systemName: Icon.about), handler: handleAboutInfoMenu)])
	
	
	private var menuItemss: [UIAction] {
		return [
			UIAction(title: "Register", image: UIImage(systemName: Constants.Design.Image.Icon.register), handler: handleRegisterMenu),
			UIAction(title: "Login", image: UIImage(systemName: Constants.Design.Image.Icon.login), handler: handleLoginMenu)
		]
	}
	
	private var menu: UIMenu = UIMenu()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		isLoggedin = APIManager.shared().authService.isLoggedIn()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
	
	private func setupUI() {
		userButton.showsMenuAsPrimaryAction = true
		userButton.overrideUserInterfaceStyle = .dark
	}
	
	@objc private func handleRegisterMenu(_ action: UIAction) {
		guard let registerVC = storyboard?.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.register) as? RegisterViewController else {
			return
		}
		
		navigationController?.pushViewController(registerVC, animated: true)
	}
	
	@objc private func handleLoginMenu(_ action: UIAction) {
		guard let loginVC = storyboard?.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.login) as? LoginViewController else {
			return
		}
		
		navigationController?.pushViewController(loginVC, animated: true)
	}
	
	@objc private func handleLogoutMenu(_ action: UIAction) {
		guard APIManager.shared().authService.isLoggedIn() else { return }
		
		APIManager.shared().authService.logOut { [weak self] error in
			if let error = error {
				print(error.localizedDescription)
			} else {
				print("logged out")
				self?.isLoggedin = false
			}
		}
	}
	
	@objc private func handleSettingsMenu(_ action: UIAction) {
		
	}
	
	@objc private func handleAboutInfoMenu(_ action: UIAction) {
		
	}
}
