//
//  main.swift
//  2l_PershinaMariaHomeWork
//
//  Created by Mariia on 23.10.2021.
//

import Foundation


// Написать функцию, которая определяет, четное число или нет.

func evenOrOddnumbe (number: Int) {
 
    number % 2 == 0 ? print("Введеное число четное \(number)"): print("Введеное число нечетное \(number)");
}

evenOrOddnumbe(number: 3)
evenOrOddnumbe(number: 888)

print ("▄■▀■▄■▀■▄■▀■▄☼ ЧуДеСнОгО ДнЯ ☼▀■▄■▀■▄■▀■▄■▀")

//  Написать функцию, которая определяет, делится ли число без остатка на 3.

func divisionWithoutRemainder (number: Int){
    number % 3 == 0 ? print ("Введеное число делится без остатка на три \(number)") : print ("Введеное число НЕ делится без остатка на три \(number)")
}
divisionWithoutRemainder(number: -72)
divisionWithoutRemainder(number: 100)

print ("ツツツツツツ█■█■█■█■█■█■█ ｡◕‿◕｡ █■█■█■█■█■█■█ツツツツツツ")


// Создать возрастающий массив из 100 чисел.

var array = Array(1...100)
print (array)

//второй способ
var array1 = [Int]()
var i = 0

while i<100 {
    array1.append(i+1)
    i += 1
}

// Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for element in array where (element % 2 == 0) || (element  % 3 != 0) {
    array = array.filter { $0 != element}
}
print (array)


// второй способ
for element in array1 where (element%2 == 0) || (element%3 == 0) {
    array1.remove(at : (array1.index(of: element)!))
}
print("__ ▂ ▃ ▅▇ █ ｡◕‿ ◕｡ █ ▇ ▅ ▃ ▂ __")

// Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

func addArrayFibonachi (limitNumber: Int) -> [Int]{
    var newArray: [Int] = [1,1]
    for Fn in 2 ... limitNumber {
        newArray.append(newArray[Fn - 1] + newArray[Fn - 2])
    }
    return newArray
}
    print(addArrayFibonachi(limitNumber: 50))


print ("▇ ▄ ▅ █ ▇ ▂ ▃ ▁ ▄ ▅ █ ▅ ▇ ")

/* Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100), следуя методу Эратосфена, нужно выполнить следующие шаги:
a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
b. Пусть переменная p изначально равна двум — первому простому числу.
c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p.
d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
e. Повторять шаги c и d, пока возможно.*/


func Erastofen (n: Int)-> [Int] {
    var erastofenArray = Array(2 ... n)
    let p: Int = 2
    for _ in stride(from: erastofenArray[2 + p], through: n, by: p) {
       erastofenArray = erastofenArray.filter { $0 % p != 0 }
    }
    return erastofenArray
    
}

print (Erastofen(n: 100))

//Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.

var newP = Erastofen(n: 100).first
print(newP!)
var p = 2
func changeP (_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}
print (newP!)
print (p)

changeP(&newP!, &p)

print(newP!)
print(p)
    
// Повторять шаги c и d, пока возможно  - НЕ ЗНАЮ КАК?!?!?!?!?
