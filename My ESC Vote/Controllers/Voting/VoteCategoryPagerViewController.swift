//
//  VoteMainPagerViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class VoteCategoryPagerViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	fileprivate let voteMenuController = VoteCategoryMenuController(collectionViewLayout: UICollectionViewFlowLayout())
	fileprivate let cellID = "cellID"
	
	fileprivate let pages = ["favouriteVC", "vocalsVC", "performanceVC"]
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.scrollDirection = .horizontal
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = Color.Secondary.lightNavy
		cv.showsVerticalScrollIndicator = false
		cv.showsHorizontalScrollIndicator = false
		
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
			make.top.equalTo(voteMenuView.bottomAnchor)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}
}

extension VoteCategoryMenuControllerDelegate: VoteMenuControllerDelegate {
	
	func didTapMenuItem(at indexPath: IndexPath) {
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
}

extension VoteCategoryPagerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x
		let offset = x / pages.count
		voteMenuController.menu
	}
	
}
