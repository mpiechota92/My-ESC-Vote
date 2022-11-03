//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController {

	@IBOutlet weak var userButton: UIButton!
	
	private var menuItems: [UIAction] {
		return [
			UIAction(title: "Register", image: UIImage(systemName: Constants.Design.Image.Icon.register), handler: handleRegisterMenu),
			UIAction(title: "Login", image: UIImage(systemName: Constants.Design.Image.Icon.login), handler: handleLoginMenu)
		]
	}
	
	private var menu: UIMenu {
		return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
	
	private func setupUI() {
		userButton.menu = menu
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
}
