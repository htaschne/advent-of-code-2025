import Foundation

func mod(_ a: Int, _ n: Int) -> Int {
    let r = a % n
    return r >= 0 ? r : r + n
}

let lines = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
    .split(whereSeparator: \.isNewline)
    .map(String.init)

var acc = 0
var dial = 50
for line in lines {
  guard let direction = line.first else { fatalError() }
  guard let value = Int(line.dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)) else { fatalError() }

  switch direction {
    case "L":
      dial = mod(dial - value, 100)
    case "R":
      dial = mod(dial + value, 100)
    default:
      fatalError()
  }

  if dial == 0 {
    acc += 1
  }
}

print(acc)
