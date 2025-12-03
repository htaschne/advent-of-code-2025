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


let banks: [[Int]] = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map { $0.compactMap { Int(String($0)) } }


var acc = 0
for bank in banks {
  acc += highestVoltage(bank)
}
print(acc)


