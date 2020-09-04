//
//  ProfileModel.swift
//  GameBoard
//
//  Created by Farras Doko on 17/08/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name_ud"
    static let descKey = "desc_ud"
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    static var desc: String {
        get{
            return UserDefaults.standard.string(forKey: descKey) ?? ""
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: descKey)
        }
    }
}
