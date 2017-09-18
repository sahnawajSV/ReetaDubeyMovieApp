//
//  MovieListCell.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var movieThumbnailImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

    func displayMovieCell(movie: Movie) {
        
        let attributedText = NSMutableAttributedString.init(string: "")
        if let text = movie.title {
            attributedText.append(NSAttributedString.init(string: "\(text)\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0)]))
        }
        
        if let text = movie.overview {
            attributedText.append(NSAttributedString.init(string: text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11.0)]))
        }
        
        attributedText.addAttributes([NSForegroundColorAttributeName: UIColor.black], range: NSMakeRange(0, attributedText.length))
        self.movieTitleLabel.attributedText = attributedText

    }
    
}
