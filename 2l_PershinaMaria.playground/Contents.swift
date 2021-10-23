import UIKit

var greeting = "Hello, playground"
print (greeting)


let a = 10
let b = 10
let c = 12

let D = b*b - 4*a*c

switch D {
    case _ where D > 0:
    print ("2 roots")
    case _ where D == 0:
    print ("1 root")
    default:
    print ("No roots")
}

// циклы

var totalSum = 0

for index in 0...10 {
    totalSum += index
}
print (totalSum)



var musicstyle = ["Rock", "Hip-Hop", "Classical"]

for musicName in musicstyle {
    print ("I love \(musicName)")
}

var country=["Россия":"ЕАЭС","США":"НАТО","Франция":"ЕС",]
for (countryName, blockName) in country {
    print ("\(countryName) в \(blockName)")
}


for i in stride(from: 1, through: 10, by: 5) {
    print (i)
}

// while

var i = 1
var resultSumWhile = 0
// пока условие = true выполняется это условие
while i <= 10 {
    resultSumWhile += i
    i += 1 // i = i + 1
}
 print (resultSumWhile)

//  цикл Repaet-While - выполняет код хотя бы один раз

var o = 1
var resultRepeatWhile = 0

repeat {
    resultRepeatWhile += o
    o += 1
} while o <= 0
print (resultRepeatWhile)


// Function

//  в параметрах можно указывать два имени функции: первое - глобалное имя, которое видно при вызове функции и  второе имя используется внутри функции, в ее коде. Можно задавать 2 имени, внутреннее имя или нижнее подчеркивание и внутреннее (тогда при вызове непонятно за что отвечает этот параметр). Лучше прописывать глобальное понятное название и буквы  a,b,c)

func myFirstFunction(firstValue someValue: Int, another: String, _ value: String) -> String {
    let c: String = String(someValue) + another + value
    return c
}

myFirstFunction(firstValue: 9, another: "17", "12")

//  если ничего не надо возвращать, то просто пустые скобки после названия функции

func textMessage () -> () {
    print ("Hello, World")
}

textMessage()
textMessage()

func nameMassage (name: String){
print ("Hello, \(name)")
}
nameMassage(name: "Max")
nameMassage(name: "Ivan")

func sum (a: Int, b: Int) -> Int {
    return a + b
}
var sumAB = sum (a: 10, b: 5)
print (sumAB)

// скозные параметры: INOUT позволяет изменить данные в функции.

var z = 10
var p = 15

// напишем функцию, которая меняет значения а и б наоброт

func changeValue(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}
print (z)
print (p)

changeValue(&z, &p)

print (z)
print (p)
