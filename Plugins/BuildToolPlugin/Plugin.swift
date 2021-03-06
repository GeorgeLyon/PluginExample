import Foundation
import PackagePlugin

@main struct Plugin: BuildToolPlugin {
  func createBuildCommands(
    context: PluginContext,
    target: Target
  ) async throws -> [Command] {
    let target = target as! SourceModuleTarget
    Diagnostics.warning("\(target.sourceFiles)")
    let inputPaths = target.sourceFiles
      .filter { $0.type == .unknown }
      .filter { $0.path.extension == "pluginExample" }
      .map { $0.path }
    let generatedSources = context.pluginWorkDirectory
      .appending("GeneratedSources")
    Diagnostics.warning("\(context.pluginWorkDirectory)")
    let outputPaths =
      inputPaths
      .map { inputPath in
        generatedSources.appending(["\(inputPath.stem).swift"])
      }
    // for outputPath in outputPaths {
    //   try "PLUGIN"
    //   .write(toFile: outputPath, atomically: , encoding: String.Encoding)
    // }
    Diagnostics.warning("OUTPUT: \(outputPaths)")
    return [
      .buildCommand(
        displayName: "Run BuildTool",
        executable: try context.tool(named: "BuildTool").path,
        arguments: zip(inputPaths, outputPaths)
          .map { "\($0.0)=\($0.1)" },
        inputFiles: inputPaths,
        outputFiles: outputPaths
      )
    ]
  }
}
