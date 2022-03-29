// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "PluginExample",
  products: [],
  dependencies: [],
  targets: [
    .executableTarget(
      name: "BuildTool"),
    .plugin(
      name: "BuildToolPlugin",
      capability: .buildTool(),
      dependencies: ["BuildTool"]),
    .executableTarget(
      name: "UsesPlugin",
      plugins: ["BuildToolPlugin"]),
  ]
)
