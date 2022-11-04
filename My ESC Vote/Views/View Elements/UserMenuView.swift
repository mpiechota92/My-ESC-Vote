//
//  UserMenuView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/11/2022.
//

import UIKit

class UserMenuView: UIView {
	
	@IBOutlet weak var optionsTableView: UITableView!
	
	
	private var storyboard: UIStoryboard!
	
	private lazy var options: [MenuOption] = [
		MenuOption(title: "Register",
				   icon: Constants.Design.Image.Icon.register,
				   handler: { [weak self] navigationController in
					   guard let vc = self?.storyboard.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.register) else { return }
					   navigationController?.pushViewController(vc, animated: true)
				   }),
		MenuOption(title: "Login",
				   icon: "",
				   handler: { [weak self] navigationController in
					   guard let vc = self?.storyboard.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.register) else { return }
					   navigationController?.pushViewController(vc, animated: true)
				   })
	]
	
	func setupView(cellNibName: String, with storyboard: UIStoryboard?) {
		self.storyboard = storyboard
		optionsTableView.dataSource = self
		self.isHidden = true
		
		let nib = UINib(nibName: Constants.Content.Nib.menuOptionCell, bundle: nil)
		optionsTableView.register(nib, forCellReuseIdentifier: Constants.UI.TableView.Cell.menuOption)
	}
	
	func setView(view: UIView, hidden: Bool) {
		UIView.transition(with: view, duration: 0.4, options: .transitionCrossDissolve) {
			view.isHidden = hidden
		}
	}
	
}

extension UserMenuView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return options.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UI.TableView.Cell.menuOption) as! MenuOptionTableViewCell
		
		let option = options[indexPath.row]
		cell.titleLabel.text = option.title
		cell.iconImageView.image = UIImage(systemName: option.icon)
		
		return cell
	}
	
}
