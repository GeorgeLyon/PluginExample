import Foundation

for argument in CommandLine.arguments.dropFirst() {
  print(argument)
  let components = argument.split(separator: "=")
  try """
    // This is a generated file based on \(components[0])

    func foo() {
      print("\(try String(contentsOfFile: String(components[0])))")
    }
    """
    .write(
      toFile: components[1],
      atomically: false,
      encoding: .utf8)
}
