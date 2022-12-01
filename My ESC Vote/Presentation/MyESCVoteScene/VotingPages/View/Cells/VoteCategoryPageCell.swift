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
	
	weak var parent: MainVoteViewController?
	weak var participantsViewController: ParticipantsViewController! {
		didSet {
			setupPageCell()
		}
	}
	
	private var viewModel: VoteCategoriesListItemViewModel!
	
	// Not needed?
	weak var scrollViewDelegate: VoteScrollViewDelegate!
	
	func fill(with viewModel: VoteCategoriesListItemViewModel) {
		self.viewModel = viewModel
	}
	
	func addParticipantsViewController(_ viewController: ParticipantsViewController) {
		
	}
	
	func setupWith(childVC viewController: ParticipantsViewController) {
		
	}
	
	private func setupPageCell() {
		participantsViewController.view.frame = contentView.bounds
		contentView.addSubview(participantsViewController.view)
		participantsViewController.didMove(toParent: parent)
	}
	
}
