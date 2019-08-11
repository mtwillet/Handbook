//
//  FavoriteModel.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/5/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation


//!!!!! Modify to be a class instead of a struct


//This is the data model for the Favorites. It will store if the item has been marked favorite and what the item is so that you can call it later.


struct Favorites {
    
    var farvoiteItem : String
    var isFavorite : Bool
    
    //Adds favorites to an array.
    static func addToFavorites(numberOfItems count: Int) -> [Favorites]{
        var favoritesList = [Favorites]()
        for index in 1...count {
            let favorites = Favorites(farvoiteItem: "Favorite Item \(index)", isFavorite: true)
            favoritesList.append(favorites)
        }
        return favoritesList
    }
    
    mutating func toggleFavorite() -> Bool {
        self.isFavorite = !self.isFavorite
        return true
    }
    
}
