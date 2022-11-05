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
	
	private var viewModel: ContestsListViewModel! = ContestsListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		contestsTableView.dataSource = self
		
		//let contest = Contest(title: "ESC 2022", country: "Kurwa", startDate: Date(), endDate: Date(), contestType: .ESC)
		
		//try? APIManager.shared().dbService.saveData(contest, to: Constants.API.Firestore.Collections.Contests.collectionName)
		
		
		setupUI()
		setupData()
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
	}
	
	private func setupData() {
		viewModel.fetchContestsData()
		contestsTableView.reloadData()
	}
}

extension ContestsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(viewModel.contestsCount())
		return viewModel.contestsCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UI.TableView.Cell.contest, for: indexPath) as? ContestTableViewCell else {
			fatalError("Could not dequeue reusable cell with identifier \(Constants.UI.TableView.Cell.contest)")
		}
		
		cell.viewModel = viewModel.contestVMAtIndex(indexPath.row)
		
		return cell
	}
	
}
