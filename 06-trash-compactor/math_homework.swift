
import Foundation

func transpose<T>(_ matrix: [[T]]) -> [[T]] {
  guard let firstRow = matrix.first else { return [] }
  return (0..<firstRow.count).map { col in
    matrix.map { $0[col] }
  }
}

let lines = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map(String.init)

var columns = lines
  .map({ $0.components(separatedBy: " ")
  .filter({ !$0.isEmpty }) })

let operations = columns.removeLast()

var acc = 0
for i in 0..<columns[0].count {
  var val = operations[i] == "+" ? 0 : 1
  for j in 0..<columns.count {
    let current = Int(columns[j][i])!
    val = operations[i] == "+" ? val + current : val * current
  }
  acc += val
}
print(acc)

let raw = try String(contentsOfFile: CommandLine.arguments[2], encoding: .ascii)
let parts = raw
  .components(separatedBy: "\n\n")
  .map { $0.split(whereSeparator: \.isNewline).map(String.init) }

acc = 0
for part in parts {
  let op = part[0]
  var val = op == "+" ? 0 : 1
  for i in 1..<part.count {
    var num = part[i]
    num.replace(" ", with: "")
    if num.count == 0 {
      continue
    }
    val = op == "+" ? val + Int(num)! : val *  Int(num)!
  }
  acc += val
}
print(acc)
