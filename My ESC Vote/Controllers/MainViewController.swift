//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController {
	
	@IBOutlet weak var userButton: UIButton!
	
	@IBOutlet weak var button: MenuButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
	
	private func setupUI() {
		button.setupButton(for: navigationController, with: storyboard)
	}
	
}
