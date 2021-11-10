//
//  main.swift
//  lesson_6_Generic
//
//  Created by Mariia on 09.11.2021.
//

import Foundation

// ДЖЕНЕРИКИ - универсальный шаблон, исп-ся для написания библиотек и в стандартном коде. Шаблоны позоволяют создавать гибкие конструкции, функции, типы без привязки к конкретному типа данных.
//задача поменять значения местами

func swapTwoInt (_ a: inout Int, _ b: inout Int) {
    let tempA = a //inout делает входящий тип переменной, а не константой, поэтому можем менять
    a = b
    b = tempA
}

var someInt = 3
var anotherInt = 10

swapTwoInt(&someInt, &anotherInt)
print (someInt)
print(anotherInt)

// для других типов данных изменится синтаксис во входных данных функции только

func swapTwoString (_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

func swapTwoDouble (_ a: inout Double, _ b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}

//напишем универсальную функцию которая будет работать с любым типом данных

func swapTwoValues <T> (_ a: inout T, _ b: inout T) {
    let tempA = a    // можем использовать 2 разных типа заменителя T U например
    a = b
    b = tempA
}

swapTwoValues(&someInt, &anotherInt)

var aString = "h"
var bString = "d"
 swapTwoValues(&aString, &bString)

//создадим стек - добавлять и удалять можно только с конца

//сначала создадим неувиверсальную версию стека

struct intStack {
    var items = [Int]() //создадим хранилище где будет храниться стек

    //метод push добавления элементов в конец стека
    
    mutating func push (_ item: Int) {
        items.append(item)
    }
    //функция удаления последнего элемента pop
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//создадим универсальный стек с дженериками с универс типом данным, который будем прописывать при вызове стека

struct Stack <Element> {
    var items = [Element]()
    
    mutating func push ( _ item: Element) {
        items.append(item)
    }
    
    mutating func pop () -> Element {
        return items.removeLast()
    }
}

// создадим экземпляр структуры стек, в котором указываем тип данных стринг

var stackOfString = Stack <String>()
stackOfString.push("one")
stackOfString.push("two")
stackOfString.push("three")

stackOfString.pop() // удалим послений three

print(stackOfString)

//  ОГРАНИЧЕНИЯ В ДЖЕНЕРИКАХ

/*class SomeClass {
    
}

protocol SomeProtocol {
    
}

func SomeFunction <T: SomeClass, U: SomeProtocol> (some: T, SomeU: U){
    
}*/

//задача: написать функцию которая будет находить определеный элемент из массива по индексу и будет выводить его на экран или будет выводить нил, если такого значения нет

func FindIndex ( ofString valueFound: String, in array: [String]) -> Int? {
    
    for (index, value) in array.enumerated() { // enumarated - метод для вытаскивания из массива пары: индекса массива и его значения. Если бы без него то вытаскиваем только значение
    
        if value == valueFound {
            return index
        }
    }
    return nil
}
 
let stringArray = ["cat", "dog", "giraf"]

if let foundIndex = FindIndex(ofString: "ct", in: stringArray) {
    print ("Our index is \(foundIndex)")
}

//сделаем метод более универсальным
//подпишем дженерик стандартным протолоком Equatable который говорит о том, что его параметры могут сравниваться между собой
func findIndexGeneric <T: Equatable> (of valueToFind: T, in array: [T]) -> Int? {
    
    for (index,value) in array.enumerated() {
        if value == valueToFind { //благодаря протоколу Equatable эти значения можно сравнить
            return index
        }
    }
    return nil
}

print(findIndexGeneric(of: "cat", in: stringArray)!)

var arrayInt = [12,45,66,4,2,1,3,5,6]

print(findIndexGeneric(of: 45, in: arrayInt)!)
    

struct testA: Equatable {
    var a: Int
    var b: Int
    
    // напишем метод который сравнивает одно значение
     static func == (lhs: testA, rhs: testA) -> Bool {
        return lhs.a == rhs.a
    }
    
}

var oneTestA = testA(a: 12, b: 3)
var twoTestA = testA(a: 6, b: 93)

if oneTestA == twoTestA {
    print ("равны")
} else {
    print("не равны")
}

//  subscripting -сокращенный вариант к члену коллекции

let array = [1,23,3,4,4,5]
 array[2] // subscripting

// также мы можем создавать такие сабскрипты для классов, структур, перечислениях и тп

/*subscript(index: Int) -> Int {
    get {
        // возвращаем
    }
    set(newValue) {
        //проводит установки
    }
} */

struct TimesTable {
    let multy: Int
    
    subscript (index: Int) -> Int {
        return multy * index
    }
}

let threeTimesTable = TimesTable(multy: 6)
print ("шесть умножить на три равно \(threeTimesTable[3])")

// используем сабскрипт вместе с сеттером

struct Welcome{
    var a = "Hello"
    var b = "Hi"
    var c = "Hola"
    
    subscript(index:Int) -> String {
        get {
            switch index {
                case 0: return a
                    case 1: return b
                case 2: return c
            default:
                return " "
            }
        } set {
            switch index{
            case 0: return a = newValue
            case 1: return b = newValue
            case 2: return c = newValue
            default:
                break
            }
        }
    }
    //можно создавать хоть сколько сабскриптов, только чтобы входные параметры отличались
    
     subscript (index: Int, word: String)-> String {
        var text = self[index]
        text += " " + word
        return text
    }
    
}

var w = Welcome()
print(w[0])

w[0] = "Privet"
print(w[0])
//вызовим второй сабскрипт
print (w[0,"GB"])

//методы отличаются от сабскрпитов еще тем, что мы вызваем методы через точку, а сабскрипты квадратными скобками

//  ЗАМЫКАНИЯ -   анонимные функции котороые позволяют создавать функцию там где ее вызывали

//задача - отсортировать массив на четные и  нечетные

let arrayValue = [4,5,6,7,8,9,10,543]

//создадим функцию которая принимает массив типа инт и функцию. которая принимает инт и выводит буль, и вся эта функция выводит массив типа инт

func filterA (array: [Int], function:(Int) -> Bool)-> [Int] {
    var newFilterArray = [Int]()
    
    for i in array {
        if function(i) { //   если выводит тру то добавлять i
            newFilterArray.append(i)
        }
    }
    return newFilterArray
}
//создадим метод сортировки по аналогу из фильтраА

func compare(i:Int) -> Bool {
    return i % 2 == 1
}

//метод проверяет нечетность
func compareNo(i:Int) -> Bool {
    return i % 2 == 0
}
//метод проверят больше 5
func compareFive(i:Int) -> Bool {
    return i > 5
}

print(filterA(array: arrayValue, function: compare))

//эти методы нам нужны только один раз и больше может и не пригодятся, чтобы все так не расписывать и используют ЗАМЫКАНИЯ

//вызываем функцию фильтра и после прописания входных параметров ставим IN и далее код. например проверяющий четност или нечетность
 
filterA(array: arrayValue, function: {(i:Int)-> Bool in
            return i % 2 == 0
})

func backward( _ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}

var nameStudents = ["Maria","Evgeniy","Vika","Vlad"]

// используем метод сортировки sorted которому передаем наше правило backward
var reversName = nameStudents.sorted(by:backward)
print(reversName)

// используем замыкания с каждым разом сокращая код

reversName = nameStudents.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reversName)

//еще сократим замыкание. Метод сортив стандартно принимает два параметра типа стринг и выводит буль. Поэтому string можно убрать

reversName=nameStudents.sorted(by: {(s1, s2) -> Bool in return s1 < s2})
print(reversName)

//можем еще сократить, понятно что метод сортид принимает два значения и сравнивает их между собой, можно использовать их сокрашение $0 и &1

reversName  = nameStudents.sorted(by: {$0 > $1})
print(reversName)

//уберем скобки- свифт поймет что то что в фигурных скобках, это относится к методу сортид

reversName = nameStudents.sorted() { $0 < $1 } //можно вообще скобки убрать после сортид
print(reversName)

//ФУНКЦИИ ВЫСШЕГО ПОРЯДКА. Sorted, Map- преобразование массива

 var arrayMap = [2,4,5,6,7,8,4,4]

var newArray = arrayMap.map {$0 * 2} //[4, 8, 10, 12, 14, 16, 8, 8]
print(newArray)

//используем мар чтобы уменьшить заглавные буквы
var lowerString = nameStudents.map {$0.lowercased()}
print(lowerString)

//можно проверить деление  на 2 и потом филтровать . Можно функции высшего порядка комбинировать
var newNewArray = arrayMap.map {$0 % 2} .filter {$0 == 1}
print(newNewArray) // [1, 1]
