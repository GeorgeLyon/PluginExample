import Foundation

for argument in CommandLine.arguments.dropFirst() {
  print(argument)
  let components = argument.split(separator: "=")
  try """
    This is a generated file (\(components[0]))
    """
    .write(
      toFile: components[1],
      atomically: true,
      encoding: .utf8)
}
