//
//  ContestantsPageView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/04/2023.
//

import Foundation
import UIKit

class ContestantsPageView: UIViewController, HavingStoryboard {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var viewModel: BaseContestantsListViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
	}
	
	func fill(with viewModel: BaseContestantsListViewModel) {
		self.viewModel = viewModel
	}
	
	private func setupTableView() {
		tableView.register(for: ContestantCell.self)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.showsVerticalScrollIndicator = false
	}

}

extension ContestantsPageView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: ContestantCell.identifier) as? ContestantCell
		
		if cell == nil { cell = ParticipantCell.instanceFromNib() }
		let contestant = viewModel.item(for: indexPath)
		cell!.fill(with: contestant)
		return cell!
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows(in: section)
	}
}
