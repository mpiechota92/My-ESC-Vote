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

protocol VoteCategoryPageCountriesTableViewDraggingDelegate: AnyObject {
	var isDraggingItem: Bool { get set }
	func setScrolling(enabled: Bool)
}

class VoteCategoryPageCell: UICollectionViewCell {
    

	static let identifier = "VoteCategoryPageCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "VoteCategoryPageCell",
					 bundle: nil)
	}
	
	@IBOutlet var countriesVoteTableView: UITableView!
	
	var countryListViewModel: CountryListViewModel!
	weak var scrollViewDelegate: VoteScrollViewDelegate!
	weak var votePageDraggingDelegate: VoteCategoryPageCountriesTableViewDraggingDelegate!
	var view: UIView!
	func setupView(for superView: UIView) {
		
	}
	
	override func awakeFromNib() {
		countriesVoteTableView.delegate = self
		countriesVoteTableView.dataSource = self
		countriesVoteTableView.dragDelegate = self
		countriesVoteTableView.dragInteractionEnabled = true
		countriesVoteTableView.showsVerticalScrollIndicator = false
	}
	
	func setupPageCell() {
		countriesVoteTableView.estimatedRowHeight = UITableView.automaticDimension
		countriesVoteTableView.rowHeight = UITableView.automaticDimension
		countriesVoteTableView.register(CountryVoteCell.nib(), forCellReuseIdentifier: CountryVoteCell.identifier)
		
		countriesVoteTableView.reloadData()
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
		return countryListViewModel.countryCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CountryVoteCell.identifier, for: indexPath) as! CountryVoteCell
		
		cell.viewModel = countryListViewModel.countryViewModelAt(index: indexPath.row)
		
		return cell
	}
	
}

extension VoteCategoryPageCell: UITableViewDragDelegate {
	
	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		dragItem.localObject = countryListViewModel.countryAt(index: indexPath.row)
		
		votePageDraggingDelegate.setScrolling(enabled: false)
		
		return [dragItem]
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let mover = countryListViewModel.removeAt(index: sourceIndexPath.row)
		countryListViewModel.insertAt(mover, index: destinationIndexPath.row)
		
		votePageDraggingDelegate.setScrolling(enabled: true)
	}
	
}
