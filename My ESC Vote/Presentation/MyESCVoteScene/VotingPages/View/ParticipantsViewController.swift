//
//  ParticipantsViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import UIKit


class ParticipantsViewController: UITableViewController, HavingStoryboard {
	
	weak var proxyParent: MainVoteViewController!
	var isDragging: Observable<Bool> = Observable(false)
	
	private var viewModel: ParticipantsListViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		bindProxyParent()
	}
	
	func fill(with viewModel: ParticipantsListViewModel) {
		self.viewModel = viewModel
		bind(to: self.viewModel)
	}
	
	func setupTableView() {
		tableView.register(for: ParticipantCell.self)
		tableView.dragDelegate = self
		tableView.dragInteractionEnabled = true
		tableView.showsVerticalScrollIndicator = false
		
//		tableView.estimatedRowHeight = UITableView.automaticDimension
//		tableView.rowHeight = UITableView.automaticDimension
	}
	
	
	private func bind(to viewModel: ParticipantsListViewModel) {
		viewModel.updateItems.observer(on: self) { [weak self] in self?.updateTableItems($0)}
	}
	
	private func bindProxyParent() {
		isDragging.observer(on: proxyParent) { [weak self] isDragging in
			self?.proxyParent.setCollectionScrolling(enabled: !isDragging)
		}
	}
	
	private func updateTableItems(_ isChanged: Bool) {
		if !isChanged { return }
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	deinit {
		isDragging.remove(observer: proxyParent)
		viewModel.updateItems.remove(observer: self)
	}
}

// MARK: - UITableViewControllerDataSource, UITableViewControllerDelegate

extension ParticipantsViewController {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: ParticipantCell.identifier, for: indexPath) as? ParticipantCell
		
		if cell == nil { cell = ParticipantCell.instanceFromNib() }
		let participant = viewModel.item(for: indexPath)
		cell!.fill(with: participant)
		
		return cell!
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows(in: section)
	}
	
	// dunno if needed
//	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//		return UITableView.automaticDimension
//	}
	
}

// MARK: - UITableViewDragDelegate

extension ParticipantsViewController: UITableViewDragDelegate {
	
	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		isDragging.value = true
		
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		dragItem.localObject = viewModel.item(for: indexPath)
		
		return [dragItem]
	}
	
	override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		//if sourceIndexPath.row != destinationIndexPath.row {
			let mover = viewModel.removeItem(at: sourceIndexPath)
			viewModel.insertItem(mover, at: destinationIndexPath)
		//}
		
		isDragging.value = false
	}

}
