//
//  VoteCategoryPageCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

protocol VoteScrollViewDelegate: AnyObject {
	func voteScrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

protocol VoteCategoryPageParticipantsTableViewDraggingDelegate: AnyObject {
	func setScrolling(enabled: Bool)
	
}

extension VoteCategoryPageParticipantsTableViewDraggingDelegate {
	func setScrolling(enabled: Bool) {}
}

class VoteCategoryPageCell: UICollectionViewCell {
    

	static let identifier = "VoteCategoryPageCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "VoteCategoryPageCell",
					 bundle: nil)
	}
	
	@IBOutlet var participantsTableView: UITableView!
	
	var participantListViewModel: ParticipantListViewModel!
	weak var scrollViewDelegate: VoteScrollViewDelegate!
	weak var votePageDraggingDelegate: VoteCategoryPageParticipantsTableViewDraggingDelegate!
	var view: UIView!
	func setupView(for superView: UIView) {
		
	}
	
	override func awakeFromNib() {
		participantsTableView.delegate = self
		participantsTableView.dataSource = self
		participantsTableView.dragDelegate = self
		participantsTableView.dragInteractionEnabled = true
		participantsTableView.showsVerticalScrollIndicator = false
	}
	
	func setupPageCell() {
		participantsTableView.estimatedRowHeight = UITableView.automaticDimension
		participantsTableView.rowHeight = UITableView.automaticDimension
		participantsTableView.register(ParticipantCell.nib(), forCellReuseIdentifier: ParticipantCell.identifier)
		
		participantsTableView.reloadData()
	}

}

extension VoteCategoryPageCell: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		scrollViewDelegate.voteScrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
		
	}
}

extension VoteCategoryPageCell: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return participantListViewModel.participantsCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantCell.identifier, for: indexPath) as! ParticipantCell
		
		cell.viewModel = participantListViewModel.modelAt(index: indexPath.row)
		
		return cell
	}
	
}

extension VoteCategoryPageCell: UITableViewDragDelegate {
	
	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		dragItem.localObject = participantListViewModel.participantAt(index: indexPath.row)
		
		votePageDraggingDelegate.setScrolling(enabled: false)
		
		return [dragItem]
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		let mover = participantListViewModel.removeAt(index: sourceIndexPath.row)
		participantListViewModel.insertAt(mover, index: destinationIndexPath.row)
		
		votePageDraggingDelegate.setScrolling(enabled: true)
		
		updateParticipantsData()
	}
	
	private func updateParticipantsData() {
		participantListViewModel.updateData()
		
		NotificationCenter.default.post(name: NSNotification.Name.participentDataDidChangeNotification, object: nil)
		
		DispatchQueue.main.async {
			self.participantsTableView.reloadData()
		}
	}
	
}
