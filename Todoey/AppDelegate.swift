//
//  AppDelegate.swift
//  Todoey
//
//  Created by Anne Kristine on 19.06.2018.
//  Copyright © 2018 Thomas Østlyng. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		do {
			_ = try Realm()
		} catch {
			print("Error initialising new realm, \(error)")
		}
		
		return true
	}
}

