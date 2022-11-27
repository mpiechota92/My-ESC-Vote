//
//  VotingViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

class ContestsViewController: UIViewController {
	
	@IBOutlet weak var contestsTableView: UITableView!
	@IBOutlet weak var menuButton: MenuButton!
	
	private var viewModel: ContestsListViewModel = ContestsListViewModel()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupData()
	}
	
	private func setupData() {
		contestsTableView.dataSource = self
		
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.color = Color.Primary.accentColor
		activityIndicator.startAnimating()
		view.addSubview(activityIndicator)
		 
		activityIndicator.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
			make.width.height.equalTo(70)
		}
		
		DispatchQueue.global(qos: .background).async {
			self.viewModel.fetchContestsData() {
				DispatchQueue.main.async {
					self.setupUI()
					activityIndicator.removeFromSuperview()
				}
			}
		}
		
		
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
		contestsTableView.register(ContestTableViewCell.nib(), forCellReuseIdentifier: ContestTableViewCell.identifier)
		contestsTableView.reloadData()
	}
	
}

extension ContestsViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(viewModel.contestsCount())
		return viewModel.contestsCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ContestTableViewCell.identifier, for: indexPath) as? ContestTableViewCell else {
			fatalError("Could not dequeue reusable cell with identifier \(ContestTableViewCell.identifier)")
		}
		
		let cellViewModel = viewModel.contestVMAtIndex(indexPath.row)
		cell.setup(with: cellViewModel)
		cell.delegate = self
		
		return cell
	}
	
}

extension ContestsViewController: ContestTableViewCellDelegate {
	
	func didTapVoteButton(forContest contest: Contest?) {
//		guard let contest = contest else { return }
//		
//		let mainVoteVC = MainVoteViewController.
//
//		navigationController?.show(mainVoteVC, sender: nil)
	}
	
}
