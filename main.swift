//
//  main.swift
//  7L-PershinaMaria
//
//  Created by Mariia on 15.11.2021.
//

import Foundation

/* Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
*/

enum printError: Error {
    case wrongName
    case noPaperInTray
    case noConnectionWithPrinter(error: Int)
    case lowLevelOfCartridge
}

struct File {
    var name: String
    var copy: Int
}

class printFile {
    var queuePrint = [
        "presentation": File(name: "presentation", copy: 1),
        "tips": File(name: "tipsForPresentation", copy: 2),
        "sheets": File(name: "sheetsForInvestors", copy: 21)
    ]
    
    var numberOfPaper: Int = 10
    var errorValue = 100
    var levelOfCartridge = 20 // 1 еденица уровня картриджа соответствует одному распечатанному листочку - как это можно в коде прописать???
    
    func printFiles(printedFile name: String, error: Int) throws {
        
        guard let document = queuePrint[name] else {
            throw printError.wrongName
        }
        
        guard document.copy < numberOfPaper else {
            throw printError.noPaperInTray
        }
        
        guard errorValue == 100 else {
            throw printError.noConnectionWithPrinter(error: errorValue)
        }
        
        guard document.copy < levelOfCartridge else {
            throw printError.lowLevelOfCartridge
        }
        
        print("\(document.name) is printing. Copies is \(document.copy)")
    }
}

let ParticipationsCollection = [
    "Ivan": "presentation",
    "Alex": "tips",
    "Alena": "sheets"
]

func printing(collection: String, printFiles: printFile) throws {
    let printMessage = 100
    let collectionView = ParticipationsCollection[collection] ?? "pop-up Window"
    
    try printFiles.printFiles(printedFile: collectionView, error: printMessage)
    
}

do {
    try printing(collection: "Alena", printFiles: printFile())
} catch printError.wrongName {
    print("You input the wrong name")
} catch printError.lowLevelOfCartridge {
    print("There is low level of cartridge. Fill up the cartridge")
} catch printError.noConnectionWithPrinter(let error) {
    print("Trouble with wi-fi connection \(error)")
} catch printError.noPaperInTray {
    print("There is no more paper in the tray. Add some paper sheets.")
}

