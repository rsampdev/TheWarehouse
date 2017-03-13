//
//  TheWarehouse.swift
//  TheWarehouse
//
//  Created by Rodney Sampson on 3/11/17.
//  Copyright © 2017 com.rsampdev. All rights reserved.
//

import Foundation

class TheWarehouse {
    
    let warehouse = Warehouse()
    
    func run() {
        Console.write("Welcome to The Warehosue. This program is used to keep track of items.")
        Console.usage()
        
        var shouldQuit = false
        
        while !shouldQuit {
            let (option, value) = Console.getOption(Console.getInput().trimmingCharacters(in: CharacterSet.newlines).lowercased())
            
            switch option {
            case .add, .addWord:
                Console.write("Item name:")
                let name = Console.getInput()
                Console.write("Item price:")
                let price = Double(Console.getInput()) ?? 0
                Console.write("Number of items:")
                let numberOfItems = Int(Console.getInput()) ?? 0
                
                var items: [Item] = []
                
                for _ in 0..<numberOfItems {
                    let item = Item(name: name, price: price)
                    items.append(item)
                }
                
                let _ = warehouse.add(items)
            case .remove, .removeWord:
                Console.write("Item ID:")
                let id = Int(Console.getInput()) ?? 0
                Console.write("Number of items to remove:")
                let numberOfItemsToRemove = Int(Console.getInput()) ?? 0
                
                let _ = warehouse.remove(howMany: numberOfItemsToRemove, itemsListID: id)
            case .inventory, .inventoryWord:
                if warehouse.getInventory() == nil {
                    continue
                }
                
                let (ids, names, prices, inStocks) = warehouse.getInventory()!
                
                for index in 0..<ids.count {
                    let id = ids[index]
                    let name = names[index]
                    let price = prices[index]
                    let numberOfItems = inStocks[index]
                    Console.write("| ID: \(id) - Name: \(name) ~ Price: \(price) ~ In stock: \(numberOfItems)")
                }
            case .help, .helpWord:
                Console.usage()
            case .quit, .quitWord:
                Console.write("Thank you for using TheWarehouse. Good bye.")
                shouldQuit = true
            default:
                Console.write("Unknown option \(value)", to: .error)
            }
            
            
        }
    }
    
}
