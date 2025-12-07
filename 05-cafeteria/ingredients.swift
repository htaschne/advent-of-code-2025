import Foundation

struct Range: Comparable {
  let lo: Int
  let hi: Int

  static func < (lhs: Range, rhs: Range) -> Bool {
    lhs.lo < rhs.lo
  }
}

func mergeRanges(_ rng: [Range]) -> [Range] {
  let ranges = rng.sorted()

  var result: [Range] = []
  var current = ranges[0]

  for r in ranges.dropFirst() {
    if r.lo <= current.hi {
      // Merge overlap
      current = Range(lo: current.lo, hi: max(current.hi, r.hi))
    } else {
      result.append(current)
      current = r
    }
  }

  result.append(current)
  return result
}

let raw = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
let parts = raw
  .components(separatedBy: "\n\n")
  .map { $0.split(whereSeparator: \.isNewline).map(String.init) }

var ranges: [Range] = []
for range in parts[0] {
  let indexes = range.components(separatedBy: "-").map({ Int($0)! })
  ranges.append(Range(lo: indexes[0], hi: indexes[1]))
}

ranges = mergeRanges(ranges)

let ingredients = parts[1].map({ Int($0)! })
var freshes = 0

for ingredient in ingredients {
  for range in ranges {
    if ingredient >= range.lo && ingredient <= range.hi {
      freshes += 1
      break
    }

    if range.lo > ingredient {
      break
    }
  }
}
print(freshes)

var acc = 0
for range in ranges {
  acc += range.hi - range.lo + 1
}
print(acc)
