//
//  APICaller.swift
//  Netfilex APP Using Xibs
//
//  Created by Macbook on 14/12/2022.
//

import Foundation
import Alamofire
struct Constrains{
    
    static let API_KEY = "5ba431c7d6dcd0a1e20773e0a8240a3b"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyBKKQkDvLmpeym1wdgzLwR40hbXgrhLjqg"
}

enum APIError : Error{
    case faildTogetData
    
}

class APICaller{
    
    static func getTrandingMovie(completionHandler : @escaping (TrandigMovieResponse) -> Void){
        
        guard let url = URL(string:"\(Constrains.baseURL)/3/trending/movie/day?api_key=\(Constrains.API_KEY)")else{return}
        
        
        AF.request(url,method: .get).responseDecodable(of: TrandigMovieResponse.self) { response in
        
            switch response.result{
            case .success(let movies):
                print(movies)
                print("yesssss")
                completionHandler(movies)
                case .failure(let error):
                print(error)
            }
        }
            }
        
          
     
    
    static func getTrendingTv(completionHandler : @escaping (TrandigMovieResponse)-> Void){
        
//        guard let url = URL(string:"\(Constrains.baseURL)/3/trending/tv/day?api_key=\(Constrains.API_KEY)")else{return}
//
        
        guard let url = URL(string: "\(Constrains.baseURL)/3/movie/popular?api_key=\(Constrains.API_KEY)&language=en-US&page=1")else{return}
        
        
        AF.request(url,method: .get).responseDecodable(of:TrandigMovieResponse.self ){ response in
            switch response.result{
            case.success(let tvMovies):
            
                print("TV movie",tvMovies)
                print("Finshed")
                completionHandler(tvMovies)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    static func getUpcomingMovies(completionHandler : @escaping (TrandigMovieResponse)-> Void){
        
        guard let url = URL(string: "\(Constrains.baseURL)/3/movie/upcoming?api_key=\(Constrains.API_KEY)&language=en-US&page=1")else{return}
        
        AF.request(url,method: .get).responseDecodable(of: TrandigMovieResponse.self){response in
            
            
            switch response.result{
            case.success(let upComing):
                print(upComing)
                print("Finshed")
                completionHandler(upComing)
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    
    
    static func getPopular(completionHandler : @escaping (TrandigMovieResponse)-> Void){
        
        
        guard let url = URL(string: "\(Constrains.baseURL)/3/movie/popular?api_key=\(Constrains.API_KEY)&language=en-US&page=1")else{return}
        
        AF.request(url,method: .get).responseDecodable(of: TrandigMovieResponse.self){response in
            
            switch response.result{
            case.success(let popular):
                print(popular)
                print("Finshed")
                completionHandler(popular)
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    
    
    
    
    static func getTopRated(completionHandler : @escaping (TrandigMovieResponse)-> Void){
        
        
        guard let url = URL(string: "\(Constrains.baseURL)/3/movie/top_rated?api_key=\(Constrains.API_KEY)&language=en-US&page=1")else{return}
        
        AF.request(url,method: .get).responseDecodable(of: TrandigMovieResponse.self){response in
            
            switch response.result{
            case.success(let TopRatedMovies):
                print(TopRatedMovies)
                print("Finshed")
                completionHandler(TopRatedMovies)
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    
    
    static func getDiscover(completionHandler : @escaping(TrandigMovieResponse)->Void){
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=697d439ac993538da4e3e60b54e762cd&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")else {return}
        
        AF.request(url, method: .get).responseDecodable(of: TrandigMovieResponse.self) { response in
            
            switch response.result{
            case .success(let movie):
                print(movie)
                print("Doneeee")
                completionHandler(movie)
            case .failure(let error):
                print(error)
                
            }
        }

    }
    
    
    static func search(query : String,completionHandler : @escaping(TrandigMovieResponse)->Void){
        
        guard let url = URL(string: "\(Constrains.baseURL)/3/search/movie?api_key=\(Constrains.API_KEY)&query=\(query)") else{
            return
        }
        
        AF.request(url,method: .get).responseDecodable(of: TrandigMovieResponse.self){response in
            
            switch response.result{
            case .success(let movies):
                print(movies)
                completionHandler(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func getMovieFromYoutube(quary : String,complationHandler : @escaping(VideoElement)->Void){
        
         guard let quary = quary.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(quary)&key=\(Constrains.YoutubeAPI_KEY)")else {return}
        
        print(quary)
        AF.request(url , method: .get).responseDecodable (of:YoutubeSearchResult.self){ response in
            switch response.result{
            case .success(let movie):
                print(movie)
                print("OKyyyyyyyy")
                complationHandler(movie.items[0])
            case .failure(let error):
                print(error)
            }
        }
    }
        
    
    
}
