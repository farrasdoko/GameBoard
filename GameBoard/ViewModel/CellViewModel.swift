//
//  CellViewModel.swift
//  GameBoard
//
//  Created by Farras Doko on 02/09/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

struct CellViewModel {
    let title: String
    let year: String
    let rate: String
    var image: UIImage? = nil

    init(item: FavGameModel, ImageUrl: String?) {
        
        title = item.title ?? ""
        year = item.year ?? "(????)"
        rate = item.rating?.description ?? ""
        if let data = item.image {
            image = UIImage(data: data)
        }
    }
    
}
