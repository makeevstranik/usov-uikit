import Cocoa
var transformKeys = ["i", "p", "r"]
let storage = ["a": [1, 2, 3, 4], "b": [5, 6, 7], "c": [8, 9, 10, 11]]
let row = storage.flatMap({$1})
print(row)
var transformedTasks = Dictionary(uniqueKeysWithValues: zip(transformKeys, [[], [], []]))
print(transformedTasks)
