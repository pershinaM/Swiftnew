//
//  main.swift
//  1l_PershinaMariia.playground
//
//  Created by Mariia on 19.10.2021.
//

import Foundation

// Первое задание в домашке: Решить квадратное уравнение.


print ("Решаем квадратное уравнение вида a*x2 + b*x + c = 0 ")

var x: Float
var x1: Float
var x2: Float

print("Ввведите значение а:")
var a = Float(readLine()!)!

print("Введите значение b:")
var b = Float(readLine()!)!

print("Введите значение c:")
var c = Float(readLine()!)!

var discriminant = b*b - 4*a*c
print ("Дискриминант = \(discriminant)")

if discriminant < 0 {
    print ("Корней нет")
    } else if discriminant == 0 {
        x = -b/(2*a)
        print ("x =  \(x)")
    } else {
        x1 = (-b +  sqrt(discriminant))/(2 * a);
        x2 = (-b - sqrt(discriminant))/(2 * a);
        print ("x1 = \(x1)");
        print ("x2 = \(x2)")
        }

 print ("================================")

// Второе задание в домашке: Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

print ("Введите длину первого катета k1, см: ")
var k1 = Float(readLine()!)!

print ("Введите длину второго катета k2, см: ")
var k2 = Float(readLine()!)!

print ("Гипотенуза вычисляется по теореме Пифагора: сумма квадратов двух катетов равняется квадрату гипотенузы.")
var hypotenuse = sqrt(k1*k1 + k2*k2)
print("Гипотенуза, см = \(hypotenuse)")

print ("Площадь прямоугольного треугольника равна половине произведения его катетов.")
var area = (0.5 * (k1*k2))
print ("Площадь треугольника,см2 = \(area)")

print ("Периметр прямоугольного треугольника равен сумме трех сторон")
var perimeter = (hypotenuse + k1 + k2)
print ("Периметр, см = \(perimeter)")

print("==================================")

// 3 задание: Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.


print("Введите сумму вклада, руб ")
var client_money = Int(readLine()!)!

print ("Введите годовой процент, %")
var interest = Int(readLine()!)!

var sumOfInterest = (client_money * interest/100);
print("Сумма годовой надбавки в валюте за 1 год =   \(sumOfInterest)")

var sumOverYear = (sumOfInterest + client_money)
print ("Сумма вклада через 1 год = \(sumOverYear)")

sumOverYear = (sumOverYear + (sumOverYear * interest/100))
sumOverYear = (sumOverYear + (sumOverYear * interest/100))
sumOverYear = (sumOverYear + (sumOverYear * interest/100))
sumOverYear = (sumOverYear + (sumOverYear * interest/100))

print ("Сумма вклада через 5 лет = \(sumOverYear)")


// конец





