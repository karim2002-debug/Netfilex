//
//  YoutubeSearchResult.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 02/02/2023.
//

import Foundation
struct YoutubeSearchResult :Codable{
    var items : [VideoElement]
}
struct VideoElement : Codable{
    
     var id : IdVideoElement
}
struct IdVideoElement : Codable{
    var kind : String
    var videoId : String
}
/**  "items": [
 {
     "kind": "youtube#searchResult",
     "etag": "4_w4_9WAohjUlmh_JNYGDjEoBtc",
     "id": {
         "kind": "youtube#video",
         "videoId": "8UXfDqANsfU"
     }
 },*/
