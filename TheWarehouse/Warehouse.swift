//
//  Warehouse.swift
//  TheWarehouse
//
//  Created by Rodney Sampson on 3/11/17.
//  Copyright © 2017 com.rsampdev. All rights reserved.
//

import Foundation

class Warehouse {
    
    var items: [[Item]] = []
    
    func add(_ itemsToAdd: [Item]) -> [Item] {
        self.items.append(itemsToAdd)
        
        guard let item = itemsToAdd.first else {
            Console.write("Invalid parameters entered. Please try again.")
            return []
        }
        
        Console.write("\(itemsToAdd.count) \(item.name)s valued at \(item.price) added to warehosue")
        return itemsToAdd
    }
    
    func remove(howMany itemsToRemove: Int, itemsListID: Int) -> [Item] {
        guard itemsListID >= 0 && itemsListID < self.items.count else {
            Console.write("This item is not in the warehouse's inventory.")
            return []
        }
        
        var items = self.items[itemsListID]
        
        guard itemsToRemove <= items.count else {
            Console.write("The number of items to delete is invlid. There are only \(items.count) of \(items.first!.name).")
            return []
        }
        
        var itemsRemoved: [Item] = []
        var numberOfItemsRemoved = 0
        var index = 0
        
        for item in items {
            itemsRemoved.append(item)
            items.remove(at: 0)
            
            numberOfItemsRemoved += 1
            index += 1
            
            if numberOfItemsRemoved == itemsToRemove {
                break
            }
        }
        
        if items.isEmpty {
            self.items.remove(at: itemsListID)
        } else {
            self.items[itemsListID] = items
        }
        
        Console.write("\(itemsToRemove) \(items.first!.name)s removed from the warehouse.")
        
        return itemsRemoved
    }
    
    func getInventory() -> (ids: [Int], itemsNames: [String], prices: [Double], inStock: [Int])? {
        var ids: [Int] = []
        var names: [String] = []
        var prices: [Double] = []
        var inStocks: [Int] = []
        var index = 0
        
        for itemList in self.items {
            ids.append(index)
            let item = itemList.first
            names.append(item?.name ?? "Nil")
            prices.append(item?.price ?? 0)
            inStocks.append(itemList.count)
            index += 1
        }
        
        if ids.count == 0 {
            Console.write("The warehouse is empty")
            return nil
        }
        
        return (ids, names, prices, inStocks)
    }
    
}
