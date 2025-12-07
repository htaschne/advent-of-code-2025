
import Foundation

struct Coord: Hashable {
  let r: Int
  let c: Int
}

func rolls(_ grid: [Coord: Character], _ r: Int, _ c: Int, _ mr: Int, _ mc: Int) -> Int {
  if grid[Coord(r: r, c: c)] != "@" { return 0 }

  var acc = 0
  for (dr, dc) in [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)] {
    if let contains = grid[Coord(r: r + dr, c: c + dc)] {
      if contains == "@" {
        acc += 1
      }
      if acc > 3 {
        return 0
      }
    }
  }
  return 1
}


let lines = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map(String.init)

var mr = 0
var mc = 0
var grid: [Coord: Character] = [:]
for (r, row) in Array(lines).enumerated() {
  for (c, col) in row.enumerated() {
    grid[Coord(r: r, c: c)] = col
    mc = max(c, mc)
  }
  mr = max(r, mr)
}

var forklifts = 0
var newGrid: [Coord: Character] = [:]
for r in 0...mr {
  for c in 0...mc {
    let ok = rolls(grid, r, c,  mr, mc)
    if ok > 0 {
      newGrid[Coord(r: r, c: c)] = "x"
      forklifts += 1
    } else {
      newGrid[Coord(r: r, c: c)] = grid[Coord(r: r, c: c)]
    }
  }
}

// for r in 0...mr {
//   for c in 0...mc {
//     guard let x = newGrid[Coord(r: r, c: c)] else { fatalError() }
//     print(x, terminator: "")
//   }
//   print()
// }
print(forklifts)
