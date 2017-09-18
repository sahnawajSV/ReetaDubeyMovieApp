//
//  MovieDetailViewController.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var movie: Movie?
    var movieDetail: MovieDetails?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loadMovieDetails()
    }
    
    func loadMovieDetails() {
        
        if let string = self.movie?.movieId {
            
            let finalURL = Constants.shared.MOVIE_DETAILS_URL + "\(string)" + Constants.shared.API_KEY
            WebServiceManager.shared.getData(urlString: finalURL) {
                (jsonData,error) in
                
                if let jsonData = jsonData {
                     DispatchQueue.main.async {
                    let model = MovieDetails.init(dictionary: jsonData)
                    self.movieDetail = model
                    
                    self.displayMovieDetails()
                  }
                }
            }
        }
    }
    
    func displayMovieDetails() {
        
        self.downloadMoviePosterImage()
        
        let attributedText = NSMutableAttributedString.init(string: "")
        if let text = self.movieDetail?.title {
            attributedText.append(NSAttributedString.init(string: "\(text)\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0)]))
        }
        
        if let array = self.movieDetail?.genreArray {
            
            var string = ""
            for genre in array {
                
                if let name = genre.name {
                    string.append( string.characters.count > 0 ? ", \(name)" : name)
                }
            }
            attributedText.append(NSAttributedString.init(string: string, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11.0)]))
        }
        
        attributedText.addAttributes([NSForegroundColorAttributeName: UIColor.white], range: NSMakeRange(0, attributedText.length))
        self.movieTitleLabel.attributedText = attributedText
        
        if let image = self.movie?.posterImage {
            self.thumbnailImageView.image = image
        }
        
        if let text = self.movieDetail?.overview {
            self.descLabel.text = text
        }
    }
    
    func downloadMoviePosterImage() {
        
        if let urlString = self.movieDetail?.posterURL {
            
            let finalString = Constants.shared.IMAGE_DOWNLOAD_PATH + Constants.shared.IMAGE_FILE_SIZE + "\(urlString)"
            
            WebServiceManager.shared.downloadImage(urlString: finalString) {
                (data,error) in
                
                if let data = data {
            
                    DispatchQueue.main.async {
                      let image = UIImage.init(data: data)
                      self.movieDetail?.posterImage = image
                      self.moviePosterImageView.image = image
                      self.moviePosterImageView.setNeedsLayout()
                    }
                }
            }
        }
    }
    
    


}
