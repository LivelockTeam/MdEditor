//
//  SceneDelegate.swift
//  MdEditor
//

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: - Public properties

	var window: UIWindow?

	// MARK: - Dependencies

	private var appCoordinator: IMainCoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Lifecycle

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		let navigationController = UINavigationController()
		appCoordinator = MainCoordinator(
			navigationController: navigationController,
			taskManager: buildTaskManager()
		)
		appCoordinator.start()

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		self.window = window
	}

	// MARK: - Private methods

	private func buildTaskManager() -> ITaskManager {
		let taskManager = TaskManager()
		let repository = TaskRepositoryStub()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		return orderedTaskManager
	}
}
