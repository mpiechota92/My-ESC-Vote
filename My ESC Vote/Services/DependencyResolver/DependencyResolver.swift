//
//  DependencyRegistry.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 23/03/2023.
//

import Foundation
import PromiseKit

protocol DependencyRegistry {
	typealias Creation<T> = () -> T
	
	func registerSingleton<T>(_ t: T.Type, _ f: @escaping Creation<T>)
	func register<T>(_ t: T.Type, _ f: @escaping Creation<T>)
	
	func unregister<T>(_ t: T.Type)
}

protocol ResolverProtocol {
	func resolve<T>() -> T
}

class DependencyResolver : ResolverProtocol, DependencyRegistry {
	static let shared: DependencyResolver = .init()
	
	private(set) var registry: [String : Creation<Any>] = [:]
	
	private init() {
		bootstrap()
	}
	
	func registerSingleton<T>(_ t: T.Type, _ f: @escaping Creation<T>) {
		var value: T!
		register(t) {
			if value == nil {
				value = f()
			}
			return value
		}
	}
	
	func register<T>(_ t: T.Type, _ f: @escaping Creation<T>) {
		registry[key(for: t)] = f
	}
	
	func unregister<T>(_ t: T.Type) {
		registry.removeValue(forKey: key(for: t))
	}
	
	func resolve<T>() -> T {
		guard let resolved = registry[key(for: T.self)]?() as? T else {
			fatalError()
		}
		return resolved
	}
	
	private func key(for type: Any.Type) -> String {
		.init(describing: type)
	}
}

