//
//  Movie.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 14/12/2022.
//

import Foundation
struct TrandigMovieResponse:Codable{
    var results : [Title]
}
struct Title:Codable{
    
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
/**"adult": false,
 "backdrop_path": "/e782pDRAlu4BG0ahd777n8zfPzZ.jpg",
 "id": 555604,
 "title": "Guillermo del Toro's Pinocchio",
 "original_language": "en",
 "original_title": "Guillermo del Toro's Pinocchio",
 "overview": "During the rise of fascism in Mussolini's Italy, a wooden boy brought magically to life struggles to live up to his father's expectations.",
 "poster_path": "/vx1u0uwxdlhV2MUzj4VlcMB0N6m.jpg",
 "media_type": "movie",
 "genre_ids": [
     16,
     14,
     18
 ],
 "popularity": 436.768,
 "release_date": "2022-11-09",
 "video": false,
 "vote_average": 8.586,
 "vote_count": 415*/
