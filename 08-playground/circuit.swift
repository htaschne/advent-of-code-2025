import Foundation

struct Edge {
  let dist: Double
  let p: [Int]
  let q: [Int]
}

func distance(p: [Int], q: [Int]) -> Double {
  let x = pow(Double(p[0] - q[0]), 2.0)
  let y = pow(Double(p[1] - q[1]), 2.0)
  let z = pow(Double(p[2] - q[2]), 2.0)
  return (x + y + z).squareRoot()
}

func groups(
  _ toCheck: Set<[Int]>,
  _ checked: Set<[Int]>,
  _ connect: [[Int]: [[Int]]]) -> [[[Int]]] {

  var visited = checked
  var allGroups: [[[Int]]] = []

  func dfs(_ node: [Int], _ group: inout [[Int]]) {
    if visited.contains(node) { return }

    visited.insert(node)
    group.append(node)

    for neighbor in connect[node] ?? [] {
      if !visited.contains(neighbor) {
        dfs(neighbor, &group)
      }
    }
  }

  for node in toCheck {
    if !visited.contains(node) {
      var group: [[Int]] = []
      dfs(node, &group)
      allGroups.append(group)
    }
  }

  return allGroups
}

let lines = try String(contentsOfFile: CommandLine.arguments[1], encoding: .ascii)
  .split(whereSeparator: \.isNewline)
  .map(String.init)

let coords = lines.map({ $0.components(separatedBy: ",").map({ Int($0)! }) })

var edges = [Edge]()
for i in 0..<(coords.count - 1) {
  for j in (i+1)..<coords.count {
    let d = distance(p: coords[i], q: coords[j])
    edges.append(Edge(dist: d, p: coords[i], q: coords[j]))
  }
}

edges.sort(by: { $0.dist < $1.dist })

let connectionsToMake = 1000

var connect = [[Int]: [[Int]]]()
for k in 0..<min(connectionsToMake, edges.count) {
  let e = edges[k]
  connect[e.p, default: []].append(e.q)
  connect[e.q, default: []].append(e.p)
}

var toCheck = Set(coords)
var checked = Set<[Int]>()

var components = groups(toCheck, checked, connect).map({ $0.count })
components.sort(by: { $0 > $1 })

var acc = 1
for i in 0...2 {
  acc *= components[i]
}
print(acc)
