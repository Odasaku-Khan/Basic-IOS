import UIKit
//Easy task
//N1
var array: [String] = ["Orange", "Apple", "Banana", "Dragon Fruit", "Mango"]

print ("Third \(array[3])")
//N2
var set: Set<Int> = [ 6 , 69 , 667 , 47 , 45 ,645 ]
set.insert(12345)

print (set)
//N3

var dict: [String:Int] = ["Swift" : 2014, "Python" : 1991, "C":1972 , "C++":1985]

print (dict["Swift"]!)

//N4
var collor: [String] = ["Red", "Violet" , "blue" , "cyan"]

collor[1] = "Green"

print (collor)

//Medium
//N1

var set1: Set<Int> = [1,2,3,4]
var set2: Set<Int> = [3,4,5,6]

print (set1.intersection(set2))

//N2

var studentsScore: [String:Int] = ["Khan": 100, "josehp " :65 , "Clanker" : 99]

studentsScore["Khan"] = 200

print (studentsScore)

//N3
var array1: [String] = ["apple", "banana"]
var array2: [String] = ["cherry", "date"]

print (array1+array2)

//Aka Hard Task
//N1
var population: [String:Int] = ["Kazakhstan": 2000000 , "China": 2000000000 , "USA": 265000000]

population.updateValue(2000000, forKey: "Albania")

print(population)

//N2
var setN1: Set<String> = ["cat", "dog"]
var setN2: Set<String> = ["dog", "mouse"]

print(setN1.union(setN2))
print(setN1.subtracting(setN2))

//N3
var grades: [String:[Int]] = ["John": [80, 70, 90], "Jane": [60, 70, 80], "Chris": [90, 100, 85], "Amy": [75, 85, 95]]

print(grades["John"]?[2])



