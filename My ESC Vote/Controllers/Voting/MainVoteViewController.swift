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

class MainVoteViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	private var voteCategoriesBar: CollectionViewSegmentedControl!
	private var pages: [CountryListViewModel]!
	private let menuButton: MenuButton = MenuButton()
	private var secondaryBackgroundView: UIView!
	private var votingPagesCollectionView: UICollectionView!
	private weak var pagesDelegate: PagesCollectionViewDelegate!
	
	private var navBarSafeAreaTopPadding: CGFloat!
	
	var contest: Contest! {
		didSet {
			setupPagesViewModels()
		}
	}
	
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
	
	private func setupUI() {
		setupBackground()
		setupNavigationBarButtons()
		setupVoteCategoriesBar()
		setupVotingPagesView()
	}
	
	private func setupBackground() {
		self.view.backgroundColor = Color.Primary.darkNavy
		
		secondaryBackgroundView = UIView(frame: .zero)
		secondaryBackgroundView.backgroundColor = Color.Primary.winter
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
	
	private func setupVoteCategoriesBar() {
		voteCategoriesBar = .instanceFromNib()
		voteCategoriesBar.delegate = self
		self.view.addSubview(voteCategoriesBar)
		
		voteCategoriesBar.setup(with: [VoteCategory.favourite.rawValue,
									   VoteCategory.vocals.rawValue,
									   VoteCategory.performance.rawValue])
		
		
		voteCategoriesBar.snp.makeConstraints { make in
			make.leading.trailing.width.equalToSuperview()
			make.top.equalTo(self.view.safeAreaLayoutGuide)
			make.height.greaterThanOrEqualTo(50)
		}
		
		voteCategoriesBar.delegate = self
		pagesDelegate = voteCategoriesBar
	}
	
	private func setupVotingPagesView() {
		let offsetValue = voteCategoriesBar.frame.height
		navBarSafeAreaTopPadding = view.safeAreaInsets.top
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: view.frame.width,
								 height: view.frame.height - (offsetValue + navBarSafeAreaTopPadding))
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = Color.Primary.winter
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.automaticallyAdjustsScrollIndicatorInsets = false
		collectionView.isPagingEnabled = true
		collectionView.isScrollEnabled = true
		
		collectionView.register(VoteCategoryPageCell.nib(), forCellWithReuseIdentifier: VoteCategoryPageCell.identifier)
		
		votingPagesCollectionView = collectionView
		self.view.addSubview(votingPagesCollectionView)
		
		votingPagesCollectionView.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide).offset(offsetValue)
			make.bottom.trailing.leading.equalToSuperview()
		}
		
		votingPagesCollectionView.delegate = self
		votingPagesCollectionView.dataSource = self
		
	}
	
	private func setupPagesViewModels() {
		pages = VoteCategory.allCases.map{ category in
			return CountryListViewModel(for: contest, category: category)
		}
	}
	
	
}

//TODO: Delete?
extension MainVoteViewController: VoteCategoryMenuControllerDelegate {
	
	func didTapMenuItem(at indexPath: IndexPath) {
		//collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
}

extension MainVoteViewController: UICollectionViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x
		let offset = x / Double(pages.count)
		//voteMenuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
	}
	
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		let item = Int(scrollView.contentOffset.x / view.frame.width)
		let indexPath = IndexPath(item: item, section: 0)
		//pagesDelegate.didSelectItem(at: item)
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let item = Int(x / view.frame.width)
		
		// Paging
		pagesDelegate.didSelectItem(at: item)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: view.frame.width, height: collectionView.frame.height)
	}
	
}

extension MainVoteViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCategoryPageCell.identifier, for: indexPath) as! VoteCategoryPageCell
		
		cell.countryListViewModel = pages[indexPath.item]
		cell.setupPageCell()
		cell.scrollViewDelegate = self
		cell.votePageDraggingDelegate = self
		
		return cell
	}
}

extension MainVoteViewController: CollectionViewSegmentedControlDelegate {
	
	func didSelectItem(_ indexPath: IndexPath) {
		votingPagesCollectionView.isPagingEnabled = false
		votingPagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		votingPagesCollectionView.isPagingEnabled = true
	}
	
}

extension MainVoteViewController: VoteScrollViewDelegate {
	func voteScrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		// TODO: Not implemented yet. Not working properly.
		guard velocity.y > CGFloat.infinity else { return }
		
		if velocity.y > 0 {
			UIView.animate(withDuration: 0.5, delay: 0) {
				self.navigationController?.setNavigationBarHidden(true, animated: true)
				let barFrame = self.voteCategoriesBar.frame
				
				self.voteCategoriesBar.frame = CGRect(x: barFrame.minX,
													  y: barFrame.minY - self.navBarSafeAreaTopPadding,
													  width: barFrame.width,
													  height: barFrame.height)
			}
		} else {
			UIView.animate(withDuration: 0.5, delay: 0) {
				self.navigationController?.setNavigationBarHidden(false, animated: true)
				
				let barFrame = self.voteCategoriesBar.frame
				self.voteCategoriesBar.frame = CGRect(x: barFrame.minX,
													  y: barFrame.minY + self.navBarSafeAreaTopPadding,
													  width: barFrame.width,
													  height: barFrame.height)
				
				
			}
		}
		
	}
}

extension MainVoteViewController: VoteCategoryPageCountriesTableViewDraggingDelegate {
	
	var isDraggingItem: Bool {
		get {
			return isDraggingItem
		}
		
		set {
			isDraggingItem = newValue
		}
	}
	
	func setScrolling(enabled: Bool) {
		votingPagesCollectionView.isScrollEnabled = enabled
	}
	
}
