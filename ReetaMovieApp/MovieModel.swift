//
//  MovieModel.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation

struct MovieModel {
    
    var pageNumber: Int?
    var totalResults: Int?
    var totalPages: Int?
    var resultsArray = [Movie]()

    init?(dictionary: Dictionary<String, Any>?) {
        
        if let dictionary = dictionary {
            
            self.pageNumber = dictionary["page"] as? Int
            self.totalResults = dictionary["total_results"] as? Int
            self.totalPages = dictionary["total_pages"] as? Int
            
            if let array = dictionary["results"] as? Array<Dictionary<String, Any>> {
                
                for dict in array {
                    
                    if let movie = Movie.init(dictionary: dict) {
                        self.resultsArray.append(movie)
                    }
                }
            }
        }
    }

}
