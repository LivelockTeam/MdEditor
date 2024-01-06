//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Sergey Rumyantsev on 05.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		window.rootViewController = ViewController()
		window.makeKeyAndVisible()

		self.window = window
	}
}
