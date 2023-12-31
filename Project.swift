import ProjectDescription

public var scripts: [TargetScript] {

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

let project = Project(
	name: "MdEditor",
	organizationName: "LivelockTeam",
	packages: [
		.package(path: "Packages/TaskManagerPackage"),
		.package(path: "Packages/DataStructures")
	],
	targets: [
		Target(
			name: "MdEditor",
			destinations: .iOS,
			product: .app,
			bundleId: "ru.LivelockTeam.MdEditor",
			infoPlist: "Info.plist",
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			scripts: scripts,
			dependencies: [
				.package(product: "TaskManagerPackage"),
				.package(product: "DataStructures")
			]
		)
	]
)
