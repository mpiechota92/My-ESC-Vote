//
//  AppDelegate.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		initFirebase()
		navigationBarAppearance()
		tabBarAppearance()
		buttonAppearance()
		
		return true
	}

	private func initFirebase() {
		FirebaseApp.configure()
		let _ = Firestore.firestore()
	}
	
	private func navigationBarAppearance() {
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.Primary.accentColor]
	}
	
	private func tabBarAppearance() {
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.Primary.accentColor], for: .selected)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.Primary.dimmedAccentColor], for: .normal)
	}
	
	private func buttonAppearance() {
		UIButton.appearance().titleLabel?.font = UIFont(name: Font.Name.metropolisThin, size: 10)
	}
	
	
	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

