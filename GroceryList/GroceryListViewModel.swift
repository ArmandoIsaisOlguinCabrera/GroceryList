//
//  GroceryListViewModel.swift
//  GroceryList
//
//  Created by Armando Isais Olguin Cabrera  on 10/06/24.
//

import Foundation

class GroceryListViewModel{
    
    private(set) var items: [GroceryItem] = []
    
    func addItem(name: String) {
        let newItem = GroceryItem(id: UUID(),name: name)
        items.append(newItem)
    }
    
    func removeItem(at index: Int){
        items.remove(at: index)
    }
}
