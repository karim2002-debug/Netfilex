//
//  Tv.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 15/12/2022.
//

import Foundation


struct TrendingTvResponse : Codable{
    
    var results : [Tv]
}

struct Tv:Codable{
    
    
    var id : Int?
    var original_language : String?
    var original_title : String?
    var media_type : String?
    var poster_path : String?
    var overview : String?
    var vote_count : Int?
    var release_date : String?
    var vote_average : Double?
}
/*"results": [
 {
     "adult": false,
     "backdrop_path": "/rAZj3toS3GErvpRgoK4R4fFaGFq.jpg",
     "id": 137437,
     "name": "National Treasure: Edge of History",
     "original_language": "en",
     "original_name": "National Treasure: Edge of History",
     "overview": "While searching for history's greatest treasure, Jess Valenzuela unburies her family's secret past.",
     "poster_path": "/noRVimjdx6PwPBCVikhExYqogsX.jpg",
     "media_type": "tv",
     "genre_ids": [
         10759
     ],
     "popularity": 44.722,
     "first_air_date": "2022-12-14",
     "vote_average": 7.167,
     "vote_count": 6,
     "origin_country": [
         "US"
     ]*/
