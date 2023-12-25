import ProjectDescription

public var scripts: [TargetScript] {

	var scripts = [TargetScript]()

	let swiftLintScriptString = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
	let swiftLintScript = TargetScript.post(script: swiftLintScriptString, name: "SwiftLint")

	scripts.append(swiftLintScript)
	return scripts
}

let project = Project(
	name: "MdEditor",
	organizationName: "LiveLock team",
	targets: [
		Target(
			name: "MdEditor",
			platform: .iOS,
			product: .app,
			bundleId: "ru.LiveLock.MdEditor",
			infoPlist: .default,
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			scripts: scripts,
			dependencies: [
				/* Target dependencies can be defined here */
				/* .framework(path: "framework") */
			]
		)
	]
)
