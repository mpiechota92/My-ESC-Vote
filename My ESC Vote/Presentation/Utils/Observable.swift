//
//  Observable.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 25/11/2022.
//

import Foundation

final class Observable<T> {
	
	struct Observer<T> {
		weak var observer: AnyObject?
		let completion: (T) -> Void
	}
	
	private var observers = [Observer<T>]()
	
	var value: T {
		didSet {
			notifyObservers()
		}
	}
	
	init(_ value: T) {
		self.value = value
	}
	
	func observer(on observer: AnyObject, completion: @escaping (T) -> Void) {
		observers.append(Observer(observer: observer, completion: completion))
		completion(self.value)
	}
	
	func remove(observer: AnyObject) {
		self.observers = observers.filter { $0.observer !== observer }
	}
	
	private func notifyObservers() {
		observers.forEach { observer in
			DispatchQueue.main.async {
				observer.completion(self.value)
			}
		}
	}
}
