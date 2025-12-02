
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
  if n.count % 2 != 0 { return true }

  for i in 0...n.count / 2 - 1 {
    if n[i] != n[i + n.count/2] {
      return true
    }
  }

  return false
}

func check(lo: String, hi: String) -> Int {
  var acc: Int = 0

  for id in Int(lo)!...Int(hi)! {
    acc += valid(n: String(id)) ? 0 : id
  }

  return acc
}

let ids = try! String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map(String.init)
  .first!

var acc: Int = 0
for id in ids.split(separator: ",") {
  let pack = id.split(separator: "-").map({String($0)})
  acc += check(lo: pack[0], hi: pack[1])
}

print(acc)

// part II
func hasRepeatingSubstring(n: String) -> Bool {
  // omg! we have smol numbers as well!
  if n.count <= 1 { return false }

  for len in 1...(n.count / 2) {
    if n.count % len != 0 { continue }
    var isRepeating = true
    
    for i in 0..<n.count {
      if n[i] != n[i % len] {
        isRepeating = false
        break
      }
    }
    
    if isRepeating {
      return true
    }
  }

  return false
}

func checkRepeating(lo: String, hi: String) -> Int {
  var acc = 0

  for id in Int(lo)!...Int(hi)! {
    acc += hasRepeatingSubstring(n: String(id)) ? id : 0
  }

  return acc
}

acc = 0
for id in ids.split(separator: ",") {
  let pack = id.split(separator: "-").map({String($0)})
  acc += checkRepeating(lo: pack[0], hi: pack[1])
}

print(acc)
