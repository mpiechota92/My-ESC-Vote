//
//  DashboardTabBarController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let storyboard = UIStoryboard(name: Constants.UI.Storyboard.main, bundle: nil)
		
		guard let homeVC = storyboard.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else {
			fatalError("Could not instantiate MainViewController")
		}
		
		guard let contestsVC = storyboard.instantiateViewController(withIdentifier: Constants.UI.ViewController.ID.contests) as? ContestsViewController else {
			fatalError("Could not instantiate VotingViewController")
		}
		
		let homeVCNav = UINavigationController(rootViewController: homeVC)
		let homeIcon = UITabBarItem(title: "Home", image: UIImage(systemName: Icon.home), selectedImage: UIImage(systemName: Icon.homeSelected))
		homeVCNav.tabBarItem = homeIcon
		
		let contestsVCNav = UINavigationController(rootViewController: contestsVC)
		let contestsIcon = UITabBarItem(title: "Contests", image: UIImage(systemName: Icon.contests), selectedImage: UIImage(systemName: Icon.contestsSelected))
		contestsVCNav.tabBarItem = contestsIcon
		
		let controllers = [homeVCNav, contestsVCNav]
		self.viewControllers = controllers
	}
}
