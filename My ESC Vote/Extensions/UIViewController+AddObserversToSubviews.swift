//
//  UIViewController+RegisterObserversForUITextFields.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

extension UIViewController {
	
	typealias NotificationGenerator<T> = (T) -> ((Notification) -> ())
	
	fileprivate func getAllTextFields(fromView view: UIView) -> [UITextField] {
		return view.subviews.flatMap { (view) -> [UITextField] in
			if view is UITextField {
				return [(view as! UITextField)]
			} else {
				return getAllTextFields(fromView: view)
			}
		}.compactMap { $0 }
	}
	
	func addObserverToTextFields(in view: UIView, with notificationGenerator: NotificationGenerator<UITextField>, forName notificationName: NSNotification.Name) {
		
		let subviews: [UITextField] = getAllSubviews(fromView: view)
		
		subviews.forEach { textField in
			let closure = notificationGenerator(textField)
			
			NotificationCenter.default.addObserver(
				forName: notificationName,
				object: textField,
				queue: OperationQueue.main,
				using: closure
			)
		}
		
	}
	
	fileprivate func getAllSubviews<T: UIView>(fromView view: UIView) -> [T] {
		
		return view.subviews.flatMap { (view) -> [T] in
			if view is T {
				return [(view as! T)]
			} else {
				return getAllSubviews(fromView: view)
			}
		}.compactMap { $0 }
		
	}
	
	func addObserversToSubviews<T: UIView>(in view: UIView, with notificationGenerator: NotificationGenerator<T>, forName notificationName: NSNotification.Name) {
		
		let subviews: [T] = getAllSubviews(fromView: view)
		
		subviews.forEach { subview in
			let closure = notificationGenerator(subview)
			
			NotificationCenter.default.addObserver(
				forName: notificationName,
				object: subview,
				queue: OperationQueue.main,
				using: closure
			)
		}
		
	}
	
	
}
