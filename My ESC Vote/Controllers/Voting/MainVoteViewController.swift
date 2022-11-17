//
//  VoteMainPagerViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class MainVoteViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	fileprivate let voteMenuController = VoteCategoryMenuController(collectionViewLayout: UICollectionViewFlowLayout())
	fileprivate let cellID = "cellID"
	
	fileprivate let pageNames = ["favourite", "vocals", "performance"]
	
	var pages: [VoteTableViewController]?
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.scrollDirection = .horizontal
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = Color.Secondary.lightNavy
		cv.showsVerticalScrollIndicator = false
		cv.showsHorizontalScrollIndicator = false
		cv.isPagingEnabled = true
		
		return cv
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		voteMenuController.delegate = self
        
		setupLayout()
    }
    
	fileprivate func setupLayout() {
		guard let voteMenuView = voteMenuController.view else { return }
		
		view.addSubview(voteMenuView)
		view.addSubview(collectionView)
		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		voteMenuView.snp.makeConstraints { make in
			make.leading.top.trailing.equalToSuperview()
			make.height.equalTo(50)
		}
		
		collectionView.snp.makeConstraints { make in
			make.top.equalTo(voteMenuView)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}
}

extension MainVoteViewController: VoteCategoryMenuControllerDelegate {
	
	func didTapMenuItem(at indexPath: IndexPath) {
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
}

extension MainVoteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x
		let offset = x / Double(pages.count)
		voteMenuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
	}
	
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		let item = Int(scrollView.contentOffset.x / view.frame.width)
		let indexPath = IndexPath(item: item, section: 0)
		collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let item = Int(x / view.frame.width)
		let indexPath = IndexPath(item: item, section: 0)
		voteMenuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VoteCategoryPageCell
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: view.frame.width, height: view.frame.height)
	}
	
}
