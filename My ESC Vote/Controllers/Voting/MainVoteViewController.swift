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

class MainVoteViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	private var voteCategoriesMenu: CollectionViewSegmentedControl!
	private var pages: [CountryListViewModel]!
	private let menuButton: MenuButton = MenuButton()
	private var secondaryBackgroundView: UIView!
	private var votingPagesCollectionView: UICollectionView!
	
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
	
	private func setupVoteCategoriesBar() {
		voteCategoriesMenu = .instanceFromNib()
		voteCategoriesMenu.delegate = self
		self.view.addSubview(voteCategoriesMenu)
		
		voteCategoriesMenu.setup(with: [VoteCategory.favourite.rawValue,
										VoteCategory.vocals.rawValue,
										VoteCategory.performance.rawValue])
		
		
		voteCategoriesMenu.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(self.view.safeAreaLayoutGuide)
			make.width.equalToSuperview()
			make.height.equalTo(60)
		}
		
		voteCategoriesMenu.delegate = self
	}
	
	private func setupVotingPagesView() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = Color.Primary.navy
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.isScrollEnabled = true
		
		collectionView.register(VoteCategoryPageCell.nib(), forCellWithReuseIdentifier: VoteCategoryPageCell.identifier)
		
		votingPagesCollectionView = collectionView
		view.addSubview(votingPagesCollectionView)
		
		votingPagesCollectionView.snp.makeConstraints { make in
			make.top.equalTo(voteCategoriesMenu.snp_bottomMargin)
			make.bottom.trailing.leading.equalTo(view)
		}
		
		votingPagesCollectionView.delegate = self
		votingPagesCollectionView.dataSource = self
	}
	
	private func setupPagesViewModels() {
		pages = VoteCategory.allCases.map({ category in
			let viewModel = CountryListViewModel(for: contest, category: category)
			return viewModel
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
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCategoryPageCell.identifier, for: indexPath) as! VoteCategoryPageCell
		
		cell.countryListViewModel = pages[indexPath.item]
		cell.setupPageCell()
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: view.frame.width, height: secondaryBackgroundView.frame.height)
	}
	
}

extension MainVoteViewController: CollectionViewSegmentedControlDelegate {
	
	func didSelectItem(_ indexPath: IndexPath) {
		votingPagesCollectionView.isPagingEnabled = false
		votingPagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		votingPagesCollectionView.isPagingEnabled = true
	}
	
}
