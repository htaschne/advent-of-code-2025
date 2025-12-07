
import Foundation

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


