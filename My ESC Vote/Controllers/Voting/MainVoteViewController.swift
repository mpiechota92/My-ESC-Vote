//
//  VoteMainPagerViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class MainVoteViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	private var voteMenuController: VoteCategoryMenuController!
	private let cellID = "cellID"
	
	private let pageNames = ["favourite", "vocals", "performance"]
	
	private var pages: [VoteTableViewController]!
	
	private let menuButton: MenuButton = MenuButton()
	private var secondaryBackgroundView: UIView!
	private var votingPagesCollectionView: UICollectionView!
	
	var contest: Contest?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tabBarController?.tabBar.isHidden = true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//voteMenuController.delegate = self
        
		setupUI()
		setupPages()
    }
    
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		tabBarController?.tabBar.isHidden = true
	}
	
	private func setupUI() {
		setupBackground()
		
		setupNavigationBarButtons()
		setupVoteCategoriesMenu()
		setupVotingPagesView()
		
	}
	
	private func setupBackground() {
		self.view.backgroundColor = Color.Primary.darkNavy
		
		secondaryBackgroundView = UIView()
		secondaryBackgroundView.backgroundColor = Color.Primary.navy
		self.view.addSubview(secondaryBackgroundView)
		
		secondaryBackgroundView.snp.makeConstraints { make in
			make.bottom.width.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide)
		}
	}
	
	private func setupNavigationBarButtons() {
		guard var rightBarButtonItem = navigationController?.navigationItem.rightBarButtonItem else { return }
		
		menuButton.setImage(UIImage(systemName: Icon.user), for: .normal)
		rightBarButtonItem = UIBarButtonItem(customView: menuButton)
	}
	
	private func setupVoteCategoriesMenu() {
		// TODO: add it
		
	}
	
	private func setupVotingPagesView() {
		let layout = UICollectionViewFlowLayout()
		print(secondaryBackgroundView.frame.width)
		layout.itemSize = CGSize(width: view.frame.width - 2, height: 200)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = Color.Primary.navy
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		
		collectionView.register(VoteCategoryPageCell.self, forCellWithReuseIdentifier: "cellID")
		
		votingPagesCollectionView = collectionView
		secondaryBackgroundView.addSubview(votingPagesCollectionView)
		
		votingPagesCollectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		votingPagesCollectionView.delegate = self
		votingPagesCollectionView.dataSource = self
	}
	
	private func setupPages() {
		pages = VoteCategory.allCases.map({ category in
			let voteVC = VoteTableViewController()
			voteVC.voteCategory = category
			
			return voteVC
		})
	}
	
	
}

extension MainVoteViewController: VoteCategoryMenuControllerDelegate {
	
	func didTapMenuItem(at indexPath: IndexPath) {
		//collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
}

extension MainVoteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x
		let offset = x / Double(pages.count)
		//voteMenuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
	}
	
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		let item = Int(scrollView.contentOffset.x / view.frame.width)
		let indexPath = IndexPath(item: item, section: 0)
		//collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let item = Int(x / view.frame.width)
		let indexPath = IndexPath(item: item, section: 0)
		//voteMenuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VoteCategoryPageCell
		cell.view = pages[indexPath.item].view
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: view.frame.width, height: view.frame.height)
	}
	
}
