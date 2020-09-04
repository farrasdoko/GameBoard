//
//  GameCell.swift
//  GameBoard
//
//  Created by Farras Doko on 20/07/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    var context: CellViewModel? {
        didSet {
            title.text = context?.title
            genre.text = context?.year
            rate.text = context?.rate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeRounded(img: img)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func makeRounded(img: UIImageView) {
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
    }

}
