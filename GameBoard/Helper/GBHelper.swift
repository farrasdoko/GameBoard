//
//  GBHelper.swift
//  GameBoard
//
//  Created by Farras Doko on 20/07/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

extension UIImageView {
    public func img3d() {
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
    }
    public func imageFrom(url: URL, blankImage:UIImage, completion: (() -> Void)? = nil) {
        
        if self.image == nil{
            self.image = blankImage
        }
        if url.absoluteString != "blankimage.com" {
            URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) -> Void in
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                    completion?()
                })
                
            }).resume()
        } else {
            self.image = UIImage(named: "emptyImg")
        }
    }
}

extension Data {
    func decoderPopGame(from data: Data?) -> PGPopGame? {
        let decoder = JSONDecoder()
        guard let data = data else {
            return nil
        }
        let popGame = try? decoder.decode(PGPopGame.self, from: data)
        
        return popGame
    }
}

extension UIButton {
    func addBorder() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitleColor(.black, for: .normal)
        self.setTitle("Add to favorite", for: .normal)
    }
    func removeBorder() {
        self.backgroundColor = .red
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0
        self.setTitleColor(.white, for: .normal)
        self.setTitle("Remove from favorite", for: .normal)
    }
}
extension String {
    func year() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateConverter = dateFormat.date(from: self)
        
        let dateOutter = DateFormatter()
        dateOutter.dateFormat = "YYYY"
        guard let date = dateConverter else { return "" }
        return dateOutter.string(from: date)
    }
}

public func convertGenre(from genres: [PGGenres]?) -> String {
    var genre = ""
    if let genres = genres {
        for (index, g) in genres.enumerated() {
            if let name = g.name {
                genre.append(name)
            } else {
                continue
            }
            if index < (genres.count - 1) { genre.append(", ") }
        }
        return genre
    } else {
        return genre
    }
}
