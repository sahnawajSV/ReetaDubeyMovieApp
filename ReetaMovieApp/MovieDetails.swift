//
//  MovieDetails.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import UIKit


    
struct MovieDetails {
    
    var isAdult: Bool?
    var backdropPath: String?
    var movieId: Int?
    var title: String?
    var posterURL: String?
    var budget: Int?
    var overview: String?
    var posterImage: UIImage?
    
    var genreArray = [MovieGenre]()
    
    init?(dictionary: Dictionary<String, Any>?) {
        
        if let dictionary = dictionary {
            
            self.posterURL = dictionary["poster_path"] as? String
            self.backdropPath = dictionary["backdrop_path"] as? String
            self.isAdult = dictionary["adult"] as? Bool
            self.overview = dictionary["overview"] as? String
            self.title = dictionary["original_title"] as? String

            if let dict = dictionary["belongs_to_collection"] as? Dictionary<String, Any> {
                
                self.movieId = dict["id"] as? Int
            }
            
            if let array = dictionary["genres"] as? Array<Dictionary<String, Any>> {
                
                for dict in array {
                    
                    if let genre = MovieGenre.init(dictionary: dict) {
                        self.genreArray.append(genre)
                    }
                }
            }
        }
    }
}

struct MovieGenre {
    
    var id: Int? = nil
    var name: String? = nil
    
    init?(dictionary: Dictionary<String, Any>?) {
        if let dictionary = dictionary {
            
            self.id = dictionary["id"] as? Int
            self.name = dictionary["name"] as? String
        }
    }
    
}
