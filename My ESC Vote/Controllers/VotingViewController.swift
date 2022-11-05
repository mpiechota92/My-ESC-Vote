//
//  VotingViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

class VotingViewController: UIViewController {
	
	@IBOutlet weak var menuButton: MenuButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
	}
	
}
