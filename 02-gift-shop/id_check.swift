
import Foundation

extension String {
  subscript(characterIndex: Int) -> Character {
      guard characterIndex >= 0 && characterIndex < self.count else {
        fatalError("Index out of bounds")
      }
      return self[index(startIndex, offsetBy: characterIndex)]
    }
}

func valid(n: String) -> Bool {
  let x = n.count
  if x % 2 != 0 {
    return true
  }

  for i in 0...n.count / 2 - 1 {
    if n[i] != n[i + n.count/2] {
      return true
    }
  }
  return false
}

func check(lo: String, hi: String) -> UInt64 {
  var acc: UInt64 = 0

  for id in UInt64(lo)!...UInt64(hi)! {
    let ok = valid(n: String(id))
    // print("checking: \(id) got: \(ok)")
    acc += ok ? 0 : id
  }

  return acc
}

let ids = try! String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
    .split(whereSeparator: \.isNewline)
    .map(String.init)
    .first!

var acc: UInt64 = 0
for id in ids.split(separator: ",") {
  let pack = id.split(separator: "-").map({String($0)})
  acc += check(lo: pack[0], hi: pack[1])
}

print(acc)

