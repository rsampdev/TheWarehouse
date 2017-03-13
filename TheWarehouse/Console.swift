//
//  AppConsole.swift
//  TheWarehouse
//
//  Created by Rodney Sampson on 3/11/17.
//  Copyright © 2017 com.rsampdev. All rights reserved.
//

import Foundation

enum OutputStream {
    case error
    case standard
}

enum Option: String {
    case add = "-a"
    case remove = "-r"
    case inventory = "-i"
    case help = "-h"
    case quit = "-q"
    case addWord = "--add"
    case removeWord = "--remove"
    case inventoryWord = "--inventory"
    case helpWord = "--help"
    case quitWord = "--quit"
    case unknown
    
    init(value: String) {
        switch value {
        case Option.add.rawValue: self = .add
        case Option.remove.rawValue: self = .remove
        case Option.inventory.rawValue: self = .inventory
        case Option.help.rawValue: self = .help
        case Option.quit.rawValue: self = .quit
        case Option.addWord.rawValue: self = .addWord
        case Option.removeWord.rawValue: self = .removeWord
        case Option.inventoryWord.rawValue: self = .inventoryWord
        case Option.helpWord.rawValue: self = .helpWord
        case Option.quitWord.rawValue: self = .quitWord
        default: self = .unknown
        }
    }
    
}

class Console {
    
    class func usage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        Console.write("\(executableName) usage:")
        Console.write("Type '-a' or '--add' to add items.")
        Console.write("Type '-r' or '--remove' to remove items.")
        Console.write("Type '-i' or '--inventory' to get the warehouse's inventory.")
        Console.write("Type '-h' or '--help' to get help.")
        Console.write("Type '-q' or '--quit' to quit the program.")
    }
    
    class func getOption(_ option: String) -> (option: Option, value: String) {
        return (Option(value: option), option)
    }
    
    class func write(_ message: String, to: OutputStream = .standard) {
        switch to {
        case .standard: print("\u{001B}[;m\(message)")
        case .error: fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    class func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
}
