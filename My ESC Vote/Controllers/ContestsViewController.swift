//
//  VotingViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit
import FirebaseFirestore

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
		
		viewModel.fetchContestsData() {
			DispatchQueue.main.async { [weak self] in
				self?.setupUI()
			}
		}
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
		contestsTableView.register(UINib(nibName: Constants.Content.Nib.contestCell, bundle: nil), forCellReuseIdentifier: Constants.UI.TableView.Cell.contest)
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
		guard let contest = contest else { return }
		
		let mainVoteVC = MainVoteViewController()
		mainVoteVC.contest = contest

		navigationController?.show(mainVoteVC, sender: nil)
	}
	
}
