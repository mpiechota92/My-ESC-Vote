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

class VoteCategoryPageCell: UICollectionViewCell, HavingNib {
	
	// TODO: Create xib for this cell
	static let identifier = String(describing: VoteCategoryPageCell.self)
	static func nib() -> UINib {
		return UINib(nibName: "VoteCategoryPageCell",
					 bundle: nil)
	}
	
	weak var parent: MainVoteViewController? {
		didSet {
			setupPageCell()
		}
	}
	
	var participantsTable: ParticipantsViewController? = nil
	
	private var viewModel: VoteCategoriesListItemViewModel!
	
	// Not needed?
	weak var scrollViewDelegate: VoteScrollViewDelegate!
	
	private var participantsViewController: ParticipantsViewController!
	
	func fill(with viewModel: VoteCategoriesListItemViewModel) {
		self.viewModel = viewModel
	}
	
	private func setupPageCell() {
		participantsViewController = ParticipantsViewController.instantiateViewController()
		participantsViewController.proxyParent = parent
		participantsViewController.view.frame = contentView.bounds
		participantsViewController.fill(with: DefaultParticipantsListViewModel(for: viewModel.contest, category: viewModel.category))
		parent?.addChild(participantsViewController)
		contentView.addSubview(participantsViewController.view)
		participantsViewController.didMove(toParent: parent)
	}
	
}
