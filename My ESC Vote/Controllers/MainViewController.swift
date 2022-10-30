//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: Constants.Design.Image.Icon.User),
			style: .plain,
			target: self,
			action: #selector(userBarButtonPressed))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//navigationController?.navigationBar.isHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		//navigationController?.navigationBar.isHidden = false
	}
	
	@objc func userBarButtonPressed() {
		
	}
	
}
