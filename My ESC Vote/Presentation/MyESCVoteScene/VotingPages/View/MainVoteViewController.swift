//
//  VoteMainPagerViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit
import PromiseKit

class MainVoteViewController: UIViewController, HavingStoryboard {

	private let categories = ["Favourite", "Vocals", "Performance"]
	
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var categoriesControl: UISegmentedControl!
	@IBOutlet weak var votingPagesCollectionView: UICollectionView!
	@IBOutlet weak var bottomVoteView: UIView!
	@IBOutlet weak var voteButton: UIButton!
	
	private var viewModel: VoteCategoriesListViewModel!
	private var menuButton: MenuButton = MenuButton()
	private var secondaryBackgroundView: UIView!
	
	private var voteLists: [VoteCategory: ParticipantsListViewModel] = [:]
	
	var contest: Contest!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupData()
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
		setupMenuButton()
		setupVoteButton()
	}
	
	private func setupVoteCategoriesBar() {
		
		// not like this
		
		for index in 0..<categoriesControl.numberOfSegments {
			categoriesControl.setAction(UIAction(handler: handleSegmentSelected(_:)), forSegmentAt: index)
			categoriesControl.setTitle(categories[index], forSegmentAt: index)
			
		}
		
		categoriesControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.Name.metropolisThin, size: Font.Size.small)!], for: .normal)
	}
	
	private func setupVotingPagesView() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		
		votingPagesCollectionView.register(for: VoteCategoryPageCell.self)
		votingPagesCollectionView.setCollectionViewLayout(layout, animated: true)
		votingPagesCollectionView.showsVerticalScrollIndicator = false
		votingPagesCollectionView.showsHorizontalScrollIndicator = false
		votingPagesCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
		votingPagesCollectionView.isPagingEnabled = true
		votingPagesCollectionView.isScrollEnabled = true
		
		votingPagesCollectionView.delegate = self
		votingPagesCollectionView.dataSource = self
	}
	
	private func setupData() {
		VoteCategory.allCases.forEach { category in
			let vc = ParticipantsViewController.instantiateViewController()
			let viewModel = DefaultParticipantsListViewModel(for: contest, category: category)
			vc.fill(with: viewModel)
			self.voteLists[category] = viewModel
			self.addChild(vc)
		}
	}
	
	private func setupMenuButton() {
		menuButton.parent = self
		menuButton.setupButton(for: navigationController, with: UIStoryboard(name: Self.identifier, bundle: nil))
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
	}
	
	private func setupVoteButton() {
		setVoteButtonTitle(categories[0])
		voteButton.titleLabel?.textAlignment = .center
	}
	
	@objc private func handleSegmentSelected(_ action: UIAction) {
		//guard let control = action.sender as! UISegmentedControl else { return }
		
		let index = categoriesControl.selectedSegmentIndex
		let indexPath = IndexPath(item: index, section: 0)
		
		setVoteButtonTitle(categories[index])
		
		votingPagesCollectionView.isPagingEnabled = false
		votingPagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		votingPagesCollectionView.isPagingEnabled = true
	}
	
	private func setVoteButtonTitle(_ categoryTitle: String) {
		let newTitle = "Vote for \(categoryTitle)"
		voteButton.setAttributedTitle(
			NSAttributedString(string: newTitle,
							   attributes: [NSAttributedString.Key.font:
												UIFont(name: Font.Name.metropolisThin,
													   size: Font.Size.medium)!]), for: .normal)
	}
}

// MARK: - Vote Button

extension MainVoteViewController {
	
	@IBAction func didTapVoteButton(_ sender: UIButton) {
		// Can vote iff logged in
		guard APIManager.shared().authService.isLoggedIn() else {
			// show information about it
			let alertVC = AlertInfoViewController.instantiateViewController()
			
			alertVC.setupWith(self,
							  title: "Information",
							  text: "Only logged in users can vote in contests. Please log in or register to vote.",
							  menuButton: menuButton,
							  leftButtonTitle: "Dismiss")
			
			alertVC.show()
			return
		}
		
		let email = APIManager.shared().authService.currentUserEmail()
		let votingService = APIManager.shared().votingService
		let index = categoriesControl.selectedSegmentIndex
		print(categories)
		let category = categories[categoriesControl.selectedSegmentIndex]
		let points = getPoints(for: category)
		let vote = Vote(email: email, _voteCategory: category, _points: points)
		
		votingService.vote(for: contest, with: vote)
			.done { [weak self] status in
				switch status {
				case .succesfful:
					self?.showAlert(title: "Voted!", text: "Thank you for casting your vote!")
				case .alreadyVoted:
					self?.showAlert(title: "Already voted!", text: "You have already cast your vote in this category.")
				case .failure:
					self?.showAlert(title: "Error!", text: "Something went wrong. If the error persits, please contact the app admin.")
				default:
					self?.showAlert(title: "Something went wrong.", text: "Hmm... Strange.")
				}
			}.catch { [weak self] error in
				self?.showAlert(title: "Error!", text: "\(error)")
			}
	}
	
	private func showAlert(title: String, text: String) {
		let alertVC = AlertInfoViewController.instantiateViewController()
		alertVC.setupWith(self,
						  title: title,
						  text: text,
						  leftButtonTitle: "Dismiss")
		
		alertVC.show()
	}
	
	private func getPoints(for voteCategory: String) -> [String: Int] {
		guard let voteCategory = VoteCategory(rawValue: voteCategory),
			  let viewModel = voteLists[voteCategory] else { return [:] }
		
		let points = viewModel.getPoints()
		return points
	}
}

// MARK: - UICollectionViewDelegate

extension MainVoteViewController: UICollectionViewDelegate {

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		let item = Int(x / view.frame.width)
		
		// Paging
		categoriesControl.selectedSegmentIndex = item
		
		let categoryTitle = categories[item]
		setVoteButtonTitle(categoryTitle)
	}

}

// MARK: - UICollectionViewDataSource

extension MainVoteViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItems(in: section)//pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCategoryPageCell.identifier, for: indexPath) as! VoteCategoryPageCell
		
		guard let childVC = self.children[indexPath.item] as? ParticipantsViewController else { return cell }
		
		cell.participantsViewController = childVC
		
		return cell
	}
	
	func setCollectionScrolling(enabled: Bool) {
		votingPagesCollectionView.isScrollEnabled = enabled
	}
	
}

// MARK: - CollectionViewSegmentedControlDelegate

//extension MainVoteViewController: CollectionViewSegmentedControlDelegate {
//
//	func didSelectItem(_ indexPath: IndexPath) {
//		votingPagesCollectionView.isPagingEnabled = false
//
//
//		votingPagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//
//
//		votingPagesCollectionView.isPagingEnabled = true
//	}
//
//}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainVoteViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
	}
	
}

// MARK: - TableViewScrollDirectionDelegate

extension MainVoteViewController: TableViewScrollDirectionDelegate {
	
	func handleScroll(in direction: ScrollDirection) {
		let height = bottomVoteView.frame.height
		let dy = height
		
		let transform = bottomVoteView.transform
		let translatedTransform: CGAffineTransform
		
		let maxY = bottomVoteView.frame.maxY
		let isHidden = view.frame.maxY < maxY
		
		switch direction {
		case .up:
			guard isHidden else { return }
			translatedTransform = transform.translatedBy(x: 0.0, y: -dy)
		case .down:
			guard !isHidden else { return }
			translatedTransform = transform.translatedBy(x: 0.0, y: dy)
		}
		
		UIView.animate(withDuration: 0.5, delay: 0) {
			self.bottomVoteView.transform = translatedTransform
		}
	}
	
}
