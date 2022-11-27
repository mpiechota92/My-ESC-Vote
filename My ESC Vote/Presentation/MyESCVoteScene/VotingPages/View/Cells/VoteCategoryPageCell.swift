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

class VoteCategoryPageCell: UICollectionViewCell {
	
	// TODO: Create xib for this cell
	static let identifier = String(describing: VoteCategoryPageCell.self)
	static func nib() -> UINib {
		return UINib(nibName: "VoteCategoryPageCell",
					 bundle: nil)
	}
	
	@IBOutlet var participantsTableView: UITableView!
	
	weak var parent: MainVoteViewController?
	var participantsTable: ParticipantsViewController? = nil
	
	var viewModel: VoteCategoriesListItemViewModel!
	
	// Not needed?
	weak var scrollViewDelegate: VoteScrollViewDelegate!
	
	private var participantsViewController: ParticipantsViewController!
	
	func fill(with viewModel: VoteCategoriesListItemViewModel) {
		self.viewModel = viewModel
		setupPageCell()
	}
	
	private func setupPageCell() {
		participantsViewController = ParticipantsViewController.instantiateViewController()
		parent?.addChild(participantsViewController)
		participantsViewController.view.frame = contentView.bounds
		participantsViewController.proxyParent = parent
		contentView.addSubview(participantsViewController.view)
		participantsViewController.didMove(toParent: parent)
		
//		participantsTableView.delegate = self
//		participantsTableView.dataSource = self
//		participantsTableView.dragDelegate = self
//		participantsTableView.dragInteractionEnabled = true
//		participantsTableView.showsVerticalScrollIndicator = false
//		participantsTableView.estimatedRowHeight = UITableView.automaticDimension
//		participantsTableView.rowHeight = UITableView.automaticDimension
		
	}
	
}
