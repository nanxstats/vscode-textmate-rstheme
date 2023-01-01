import Foundation

@objc class Person: Entity {
  var name: String!
  var age: Int!

  init(name: String, age: Int) {
    /* /* ... */ */
  }

  // Return a descriptive string for this person
  func description(offset: Int = 0) -> String {
    return "\(name) is \(age + offset) years old"
  }
}

func minMax(array: [Int]) -> (min: Int, max: Int)? {
  if array.isEmpty { return nil }
  var currentMin = array[0]
  var currentMax = array[0]
  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}
