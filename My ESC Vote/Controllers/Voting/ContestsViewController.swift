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
	
	private var viewModel: ContestsListViewModel! = ContestsListViewModel()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupData()
	}
	
	private func setupUI() {
		menuButton.setupButton(for: navigationController, with: storyboard)
		contestsTableView.register(UINib(nibName: Constants.Content.Nib.contestCell, bundle: nil), forCellReuseIdentifier: Constants.UI.TableView.Cell.contest)
		contestsTableView.reloadData()
	}
	
	private func setupData() {
		contestsTableView.dataSource = self
		
		viewModel.fetchContestsData() {
			DispatchQueue.main.async { [weak self] in
				self?.setupUI()
			}
		}
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
		cell.setup()
		return cell
	}
	
}
