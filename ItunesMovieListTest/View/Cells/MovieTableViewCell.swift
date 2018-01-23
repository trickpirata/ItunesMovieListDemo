//
//  MovieTableViewCell.swift
//  ItunesMovieListTest
//
//  Created by Patrick Gorospe on 1/22/18.
//  Copyright © 2018 Patrick Gorospe. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtReleaseDate: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
