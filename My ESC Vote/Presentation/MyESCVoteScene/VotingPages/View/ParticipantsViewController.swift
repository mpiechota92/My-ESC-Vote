//
//  ParticipantsViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import UIKit

enum ScrollDirection {
	case up
	case down
}

protocol TableViewScrollDirectionDelegate: AnyObject {
	func handleScroll(in direction: ScrollDirection)
}

class ParticipantsViewController: UIViewController, HavingStoryboard {
	
	@IBOutlet private var tableView: UITableView!
	
	weak var proxyParent: MainVoteViewController!
	weak var scrollDelegate: TableViewScrollDirectionDelegate!
	
	var isDragging: Observable<Bool> = Observable(false)
	
	private var viewModel: ParticipantsListViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		bindProxyParent()
	}
	
	func fill(with viewModel: ParticipantsListViewModel) {
		self.viewModel = viewModel
		//bind(to: self.viewModel)
	}
	
	func setupTableView() {
		tableView.register(for: ParticipantCell.self)
		tableView.dragDelegate = self
		tableView.dataSource = self
		tableView.delegate = self
		tableView.dragInteractionEnabled = true
		tableView.showsVerticalScrollIndicator = false
	}
	
	private func bindProxyParent() {
		isDragging.observer(on: proxyParent) { [weak self] isDragging in
			self?.proxyParent.setCollectionScrolling(enabled: !isDragging)
		}
		
		scrollDelegate = proxyParent
	}
	
	deinit {
		if proxyParent != nil { isDragging.remove(observer: proxyParent) }
		viewModel.updateItems.remove(observer: self)
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ParticipantsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: ParticipantCell.identifier, for: indexPath) as? ParticipantCell
		
		if cell == nil { cell = ParticipantCell.instanceFromNib() }
		let participant = viewModel.item(for: indexPath)
		cell!.fill(with: participant)
		
		if indexPath.row == 0 {
			print("0. \(participant.place.value)")
		}
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows(in: section)
	}
}

// MARK: - UITableViewDragDelegate

extension ParticipantsViewController: UITableViewDragDelegate {
	
	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		isDragging.value = true
		
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		let row = viewModel.item(for: indexPath)
//		row.place.value = -1
		dragItem.localObject = row
		
		
		return [dragItem]
	}
	
	func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
		let movedRow = session.items[0]
		let model = movedRow.localObject as! ParticipantsListItemViewModel
		print(model.place.value)
		
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let mover = viewModel.removeItem(at: sourceIndexPath)
		viewModel.insertItem(mover, at: destinationIndexPath)
			
		isDragging.value = false
		updateTable(from: sourceIndexPath, to: destinationIndexPath)
	}
	
	private func updateTable(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		viewModel.updateItems.value = true
		
		let range: ClosedRange<Int>
		let fromRow = sourceIndexPath.row
		let toRow = destinationIndexPath.row
		
		range = fromRow <= toRow ? fromRow...toRow : toRow...fromRow
		
		DispatchQueue.main.async {
			for index in range {
				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
			}
		}
	}
	
	func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
		return nil
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let scrollDirection: ScrollDirection = velocity.y > 0 ? .down : .up
		
		scrollDelegate.handleScroll(in: scrollDirection)
	}
}
