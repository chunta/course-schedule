
let course00: [[Int]] = [[1, 2], [1, 3], [2, 3], [4, 5]]
let course01: [[Int]] = [[0, 1], [1, 0]]

func cookCourseMap(_ course: [[Int]]) -> [Int: [Int]] {
  var courseMap: [Int: [Int]] = [:]
  for i in 0 ..< course.count {
    let list = course[i]
    if let _ = courseMap[list[0]] {
      courseMap[list[0]]!.append(list[1])
    } else {
      courseMap[list[0]] = [list[1]]
    }
  }
  return courseMap
}
var courseMap00 = cookCourseMap(course00)
var courseMap01 = cookCourseMap(course01)

// [0,1] [1, 0]
func travelDfs(_ courseMap: inout [Int: [Int]], _ visitedSet: inout Set<Int>, _ stack: inout [Int]) {
  if let top = stack.last {
    if let values = courseMap[top] {
       for i in 0 ..< values.count {
         if visitedSet.contains(values[i]) {
           if let find = courseMap[values[i]], find.count > 0 {
             print("There is the impossible course schedule, return at line 112")
             return
           }
         }
         visitedSet.insert(values[i])
         stack.append(values[i])
         travelDfs(&courseMap, &visitedSet, &stack)
         print(stack[stack.count - 1])
         /*
         if find courseMap with key : stack[stack.count - 1], if value is empty
         then remove value from courseMap
         */
         let val = stack[stack.count - 1]
         print("line 112 val:", val)
         if let find = courseMap[val], find.count == 0 {
           removeFromTable(&courseMap, val)
         }
         stack.removeLast()
       }
    } else {
      print("Not found the course's prerequisite for \(top)")
      removeFromTable(&courseMap, top)
    }
  }
}

func removeFromTable(_ courseMap: inout [Int: [Int]], _ tvalue: Int) {
  for (key, list) in courseMap {
    for i in 0 ..< list.count {
      if list[i] == tvalue {
        courseMap[key]!.remove(at: i)
        break
      }
    }
  }
}

func courseSchedule(_ courseMap: inout [Int: [Int]]) -> Bool {
  var visitedSet = Set<Int>()
  var stack: [Int] = []
  for (_, value) in courseMap.enumerated() {
    for i in 0 ..< value.value.count {
      if visitedSet.contains(value.value[i]) {
        if let find = courseMap[value.value[i]], find.count > 0 {
          print("Find:",find)
          print("There is the impossible course schedule. return at line 158")
          return false
        }
      }
      visitedSet.insert(value.value[i])
      stack.append(value.value[i])
      travelDfs(&courseMap, &visitedSet, &stack)
      print(stack[stack.count - 1])
      let val = stack[stack.count - 1]
      if let find = courseMap[val], find.count == 0 {
        removeFromTable(&courseMap, val)
      }
      stack.removeLast()
    }
  }
  print(stack)
  var count = 0
  for (_, value) in courseMap {
    count = count + value.count
  }
  return count == 0
}

print(courseSchedule(&courseMap00))

print("----")

print(courseSchedule(&courseMap01))
