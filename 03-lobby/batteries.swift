import Foundation

// Not proud :(
func highestVoltage(_ bank: [Int]) -> Int {
  var hi = 0

  for i in 0..<(bank.count - 1) {
    hi = max(bank[i], hi)
  }

  var next = 0
  for i in 0..<bank.count {
    if bank[i] == hi {
      for j in (i + 1)..<bank.count {
        next = max(bank[j], next)
      }
      break
    }
  }

  return 10 * hi + next
}

func highestBank(_ bank: [Int]) -> Int {
  var acc = 0
  var biggestIndex = 0
  for j in [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] {
    var biggest = 0
    for i in (biggestIndex)..<(bank.count - j) {
      if bank[i] > biggest {
        biggest = bank[i]
        biggestIndex = i + 1
      }
      
    }
    acc = acc * 10 + biggest
  }
  return acc
}

let banks: [[Int]] = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map { $0.compactMap { Int(String($0)) } }


var acc = 0
for bank in banks {
  acc += highestVoltage(bank)
}
print(acc)

acc = 0
for bank in banks {
  acc += highestBank(bank)
}

print(acc)
