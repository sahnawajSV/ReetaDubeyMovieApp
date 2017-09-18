//
//  Movie.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    
    var voteCount: Int?
    var movieId: Int?
    var isVideo: Bool?
    
    var voteAverage: Float?
    var title: String?
    var popularity: Float?
    var posterURL: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: String?
    
    var backdropPath: String?
    var isAdult: Bool?
    var overview: String?
    var releaseDate: String?
    var posterImage: UIImage?
    
    init?(dictionary: Dictionary<String, Any>?) {
        
        if let dictionary = dictionary {
            
            self.voteCount = dictionary["vote_count"] as? Int
            self.movieId = dictionary["id"] as? Int
            self.isVideo = dictionary["video"] as? Bool
            self.voteAverage = dictionary["vote_average"] as? Float
            
            self.title = dictionary["title"] as? String
            self.popularity = dictionary["popularity"] as? Float
            self.posterURL = dictionary["poster_path"] as? String
            self.originalLanguage = dictionary["original_language"] as? String
            self.originalTitle = dictionary["original_title"] as? String
            self.genreIds = dictionary["genre_ids"] as? String
            self.backdropPath = dictionary["backdrop_path"] as? String
            self.isAdult = dictionary["adult"] as? Bool
            self.overview = dictionary["overview"] as? String
            self.releaseDate = dictionary["release_date"] as? String
            
        }
    }
}
