//
//  Dismissable.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/12/2022.
//

import UIKit

typealias ShowClosure = (() -> Void)

protocol DismissableDelegate: UIView {
	func willAppear()
	func willDismiss()
}

protocol Dismissable: AnyObject {
	
	var xButton: UIButton { get }
	var dismissableViewController: UIViewController { get }
	var triggerDismiss: Selector { get }
	var showView: ShowClosure { get }
	var dismissableDelegate: DismissableDelegate { get set }
	
}

extension Dismissable {
	
	var triggerDismiss: Selector {
		return #selector(UIViewController.triggerDismiss)
	}
	
	var showView: ShowClosure {
		dismissableDelegate.willAppear()
		return self.dismissableViewController.showView
	}
	
	func setupDismissableView(_ viewController: UIViewController) {
		viewController.addChild(dismissableViewController)
		self.dismissableViewController.view.frame = viewController.view.bounds
		viewController.view.addSubview(self.dismissableViewController.view)
		self.dismissableViewController.didMove(toParent: viewController)
		
		setupButton()
		setupBackground()
	}
	
	private func setupButton() {
		self.xButton.addTarget(self, action: triggerDismiss, for: .touchUpInside)
	}
	
	private func setupBackground() {
		guard let view = dismissableViewController.view else { return }
		
		view.target(forAction: triggerDismiss, withSender: view)
	}
}

fileprivate extension UIViewController {
	
	var contentView: UIView? {
		guard let subView = self.view.subviews.first else { return nil }
		
		subView.layer.cornerRadius = subView.frame.height / 10
		
		return subView
	}
	
	@objc func triggerDismiss(_ sender: Any? = nil) {
		guard let contentView = self.contentView else { return }
		
		let transform = contentView.transform
		let scaledTransform = transform.scaledBy(x: 0.1, y: 0.1)
		DispatchQueue.main.async {
			UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut]) {
				contentView.transform = scaledTransform
				contentView.alpha = 0
				self.view.alpha = 0
			} completion: { done in
				if done {
					self.view.removeFromSuperview()
					self.removeFromParent()
				}
			}
		}
	}
	
	var showView: ShowClosure {
		let closure = {
			guard let contentView = self.contentView else { return }
			
			let initialTransform = contentView.transform
			contentView.transform = .identity.scaledBy(x: 0, y: 0)
			
			DispatchQueue.main.async {
				UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [.curveEaseIn]) {
					contentView.transform = initialTransform
					contentView.alpha = 1
					self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
				}
			}
		}
		
		return closure
	}
	
}
