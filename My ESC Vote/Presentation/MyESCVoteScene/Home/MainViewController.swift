//
//  MainViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit

class MainViewController: UIViewController, HavingStoryboard {
	
	@IBOutlet private weak var image: UIImageView!
	@IBOutlet private weak var timer: CountdownTimer!

	private var menuButton: MenuButton = MenuButton()
	
	private let segueID = "xyz"
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//self.timer = CountdownTimer.instantiateFromNib()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		menuButton.parent = self
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
	
	func setupUI() {
		let blurEffect = UIBlurEffect(style: .dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = image.bounds
		blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		blurEffectView.alpha = 0.5
		image.addSubview(blurEffectView)
		
		menuButton.setupButton(for: navigationController, with: storyboard)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
		//try? self.timer.setupTimer(with: "11-12-2022 15:00:00")

		try? timer.setupTimer(with: "09-05-2023 20:00:00")
	}
	
	@IBAction func didTapVoteButton(_ sender: Any) {
		let vc = MainVoteViewController.instantiateViewController()
		let contest = Contest(title: "ESC 2023 SEMI 1", startDate: Date(), country: CountryName.UnitedKingdom, contestType: .ESCS1)
		//let contest = Contest(country: CountryName.Armenia, startDate: Date(), contestType: .JSEC)
		//let viewModel = DefaultVoteCategoriesListViewModel(for: [.favourite, .vocals, .performance], in: contest)
		let params = VoteCategoriesListViewModelParams(categories: [.favourite, .vocals, .performance], contest: contest)
		
		let viewModel: VoteCategoriesListViewModel = DependencyResolver.shared.resolve()
		
		vc.fill(with: viewModel)
		vc.contest = contest
		
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
}
