//
//  VoteMainPagerViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

enum VoteCategory: String, Codable, CaseIterable {
	case favourite = "Favourite"
	case vocals = "Vocals"
	case performance = "Performance"
}

protocol PagesCollectionViewDelegate: AnyObject {
	
	func didSelectItem(at index: Int)
	
}

class MainVoteViewController: UIViewController, HavingStoryboard {

	@IBOutlet private var voteCategoriesBar: CollectionViewSegmentedControl!
	@IBOutlet private var votingPagesCollectionView: UICollectionView!
	
	private var viewModel: VoteCategoriesListViewModel!
	
	private var secondaryBackgroundView: UIView!
	private weak var pagesDelegate: PagesCollectionViewDelegate!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		votingPagesCollectionView.reloadData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		tabBarController?.tabBar.isHidden = false
	}
		
	
	func fill(with viewModel: VoteCategoriesListViewModel) {
		self.viewModel = viewModel
	}
	
	private func setupUI() {
		setupVoteCategoriesBar()
		setupVotingPagesView()
	}
	
	private func setupBackground() {
//		self.view.backgroundColor = Color.Primary.darkNavy
//
//		secondaryBackgroundView = UIView(frame: .zero)
//		secondaryBackgroundView.backgroundColor = Color.Primary.winter
//		self.view.addSubview(secondaryBackgroundView)
//
//		secondaryBackgroundView.snp.makeConstraints { make in
//			make.bottom.width.equalToSuperview()
//			make.top.equalTo(view.safeAreaLayoutGuide)
//		}
	}
	
	private func setupNavigationBarButtons() {
//		guard var rightBarButtonItem = navigationController?.navigationItem.rightBarButtonItem else { return }
//
//		menuButton.setImage(UIImage(systemName: Icon.user), for: .normal)
//		rightBarButtonItem = UIBarButtonItem(customView: menuButton)
	}
	
	private func setupVoteCategoriesBar() {
//		voteCategoriesBar = .instanceFromNib()
		voteCategoriesBar.delegate = self
//		self.view.addSubview(voteCategoriesBar)
		
		voteCategoriesBar.setup(with: [VoteCategory.favourite.rawValue,
									   VoteCategory.vocals.rawValue,
									   VoteCategory.performance.rawValue])
		
		
//		voteCategoriesBar.snp.makeConstraints { make in
//			make.leading.trailing.width.equalToSuperview()
//			make.top.equalTo(self.view.safeAreaLayoutGuide)
//			make.height.greaterThanOrEqualTo(50)
//		}
		
		voteCategoriesBar.delegate = self
		pagesDelegate = voteCategoriesBar
	}
	
	private func setupVotingPagesView() {
//		let offsetValue = voteCategoriesBar.frame.height
//		navBarSafeAreaTopPadding = view.safeAreaInsets.top
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
//		layout.itemSize = CGSize(width: view.frame.width,
//								 height: view.frame.height - (offsetValue + navBarSafeAreaTopPadding))
		
		votingPagesCollectionView.setCollectionViewLayout(layout, animated: true)
		votingPagesCollectionView.showsVerticalScrollIndicator = false
		votingPagesCollectionView.showsHorizontalScrollIndicator = false
		votingPagesCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
		votingPagesCollectionView.isPagingEnabled = true
		votingPagesCollectionView.isScrollEnabled = true
//
//		votingPagesCollectionView.register(VoteCategoryPageCell.nib(), forCellWithReuseIdentifier: VoteCategoryPageCell.identifier)
		
//		votingPagesCollectionView = collectionView
//		self.view.addSubview(votingPagesCollectionView)
		
//		votingPagesCollectionView.snp.makeConstraints { make in
//			make.top.equalTo(self.view.safeAreaLayoutGuide).offset(offsetValue)
//			make.bottom.trailing.leading.equalToSuperview()
//		}
		
		votingPagesCollectionView.delegate = self
		votingPagesCollectionView.dataSource = self
		
	}
	
	
}

// MARK: - UICollectionViewDelegate

extension MainVoteViewController: UICollectionViewDelegate {

//	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//		let item = Int(scrollView.contentOffset.x / view.frame.width)
//		let indexPath = IndexPath(item: item, section: 0)
//		//pagesDelegate.didSelectItem(at: item)
//	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let item = Int(x / view.frame.width)
		
		// Paging
		pagesDelegate.didSelectItem(at: item)
	}
	
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return .init(width: view.frame.width, height: collectionView.frame.height)
//	}
	
}

// MARK: - UICollectionViewDataSource

extension MainVoteViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItems(in: section)//pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCategoryPageCell.identifier, for: indexPath) as! VoteCategoryPageCell
		
		let cellViewModel = viewModel.item(for: indexPath) //pages[indexPath.item]
		cell.fill(with: cellViewModel)
		cell.parent = self
		
		return cell
	}
	
	func setCollectionScrolling(enabled: Bool) {
		votingPagesCollectionView.isScrollEnabled = enabled
	}
	
}

// MARK: - CollectionViewSegmentedControlDelegate

extension MainVoteViewController: CollectionViewSegmentedControlDelegate {
	
	func didSelectItem(_ indexPath: IndexPath) {
		votingPagesCollectionView.isPagingEnabled = false
		votingPagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		votingPagesCollectionView.isPagingEnabled = true
	}

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainVoteViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
	}
	
}
