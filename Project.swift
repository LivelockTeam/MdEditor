import ProjectDescription

// Settings

enum ProjectSettings {
	public static var projectName: String { "MdEditor" }
	public static var organizationName: String { "LivelockTeam" }
	public static var bundleId: String { "ru.LivelockTeam.MdEditor" }
}

// Scripts

private var scripts: [TargetScript] {
	var scripts = [TargetScript]()

	let swiftLintScriptString = """
								export PATH="$PATH:/opt/homebrew/bin"
								if which swiftlint > /dev/null; then
									swiftlint
								else
									echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
									exit 1
								fi
								"""
	let swiftLintScript = TargetScript.post(
		script: swiftLintScriptString,
		name: "SwiftLint",
		basedOnDependencyAnalysis: false
	)

	scripts.append(swiftLintScript)
	return scripts
}

// Targets

let mainTarget = Target(
	name: ProjectSettings.projectName,
	destinations: .iOS,
	product: .app,
	bundleId: ProjectSettings.bundleId,
	infoPlist: "Info.plist",
	sources: ["Sources/**", "Shared/**"],
	resources: ["Resources/**"],
	scripts: scripts,
	dependencies: [
		.package(product: "TaskManagerPackage"),
		.package(product: "DataStructures")
	]
)

let unitTestsTarget = Target(
	name: "\(ProjectSettings.projectName)Tests",
	platform: .iOS,
	product: .unitTests,
	bundleId: ProjectSettings.bundleId,
	sources: ["MdEditorTests/Sources/**"],
	dependencies: [
		.target(name: "MdEditor")
	]
)

let uiTestsTarget = Target(
	name: "\(ProjectSettings.projectName)UITests",
	platform: .iOS,
	product: .uiTests,
	bundleId: ProjectSettings.bundleId,
	sources: ["MdEditorUITests/Sources/**", "Shared/**"],
	dependencies: [
		.target(name: "MdEditor")
	]
)

// Project

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	packages: [
		.package(path: "Packages/TaskManagerPackage"),
		.package(path: "Packages/DataStructures")
	],
	targets: [
		mainTarget,
		unitTestsTarget,
		uiTestsTarget
	],
	schemes: [
		Scheme(
			name: "\(ProjectSettings.projectName)",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)"]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)")
		),
		Scheme(
			name: "\(ProjectSettings.projectName)Tests",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)Tests"]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)Tests")
		),
		Scheme(
			name: "\(ProjectSettings.projectName)UITests",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)UITests"]),
			testAction: .targets(["\(ProjectSettings.projectName)UITests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)UITests")
		)
	]
)
