import Foundation

// Because Swift's % operator is not the math operator
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

// Part II

enum Direction {
    case left
    case right
}

func hits(from dial: Int, steps value: Int, direction: Direction) -> Int {
    if value == 0 { return 0 }
    if dial == 0 { return value / 100 }

    let first: Int
    switch direction {
    case .left:
        first = dial
    case .right:
        first = 100 - dial
    }

    if value < first {
        return 0
    }
    return 1 + (value - first) / 100
}

acc = 0
dial = 50
for line in lines {
  guard let direction = line.first else { fatalError() }
  guard let value = Int(line.dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)) else { fatalError() }

  switch direction {
    case "L":
      acc += hits(from: dial, steps: value, direction: .left)
      dial = mod(dial - value, 100)
    case "R":
      acc += hits(from: dial, steps: value, direction: .right)
      dial = mod(dial + value, 100)
    default:
      fatalError()
  }
}
print(acc)

