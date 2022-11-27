//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController {
	
	private var menuButton: MenuButton = MenuButton()
	
	private let segueID = "xyz"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		guard let vc = segue.destination as? MainVoteViewController else { return }
		
		let viewModel = DefaultVoteCategoriesListViewModel(for: [.favourite, .vocals, .performance])
		vc.fill(with: viewModel)
	}
	
	@IBAction func didTapVoteButton(_ sender: Any) {
		let vc = MainVoteViewController.instantiateViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
}
