//
//  DashboardTabBarController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

typealias Icon = Constants.Design.Image.Icon

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let storyboard = UIStoryboard(name: Constants.UI.Storyboard.main, bundle: nil)
		
		guard let homeVC = storyboard.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.main) as? MainViewController else {
			fatalError("Could not instantiate MainViewController")
		}
		
		guard let votingVC = storyboard.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.voting) as? VotingViewController else {
			fatalError("Could not instantiate VotingViewController")
		}
		
		let homeVCNav = UINavigationController(rootViewController: homeVC)
		let homeIcon = UITabBarItem(title: "Home", image: UIImage(systemName: Icon.home), selectedImage: UIImage(systemName: Icon.homeSelected))
		homeVCNav.tabBarItem = homeIcon
		
		let votingVCNav = UINavigationController(rootViewController: votingVC)
		let votingIcon = UITabBarItem(title: "Vote", image: UIImage(systemName: Icon.voting), selectedImage: UIImage(systemName: Icon.votingSelected))
		votingVCNav.tabBarItem = votingIcon
		
		let controllers = [homeVCNav, votingVCNav]
		self.viewControllers = controllers
	}
}
