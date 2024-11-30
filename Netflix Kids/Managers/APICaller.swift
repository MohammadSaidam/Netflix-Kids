//
//  APICaller.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 18/09/2024.
//

import Foundation
import UIKit

enum APIError :Error{
    case failedToGetData
}
class APICaller {
    static let shared = APICaller()
    
    // getMoviesforKids
    func getTrendingMovies(completion :@escaping (Result<[Title], Error>)  -> Void){
        
        
        /*
         GET GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&sort_by=popularity.desc&with_genres=16
         
         GET https://api.themoviedb.org/3/trending/tv/day?api_key=YOUR_API_KEY&with_genres=16
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&first_air_date.lte=2000&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/search/tv?api_key=YOUR_API_KEY&query=christmas&with_genres=16
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16,10759&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&first_air_date.lte=2000&sort_by=popularity.desc
         
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16,10759&certification_country=US&certification.lte=G&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16,10759&certification_country=US&certification.lte=G&sort_by=popularity.desc
         
         https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=vote_average.desc&vote_count.gte=50
         
         GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc&release_date.gte=2023-01-01
         
         https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16,35&sort_by=popularity.desc&language=en-US&primary_release_date.gte=2020-01-01&primary_release_date.lte=2024-11-11
         
         GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16,35&certification_country=US&certification.lte=PG&sort_by=popularity.desc
         
         */
        
        
        guard let url = URL(string: "\(Constants.getTrendingMoviesAPI)") else{return}
        
   
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data,_,error in
            guard let data = data ,error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                //                print(results.results[0].original_title)
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    
    
    /*
     GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=popularity.desc
     
     */
    
    
    
    //    Trending Cartoon (All Media Types):
    
    /*
     GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&sort_by=popularity.desc
     GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=popularity.desc
     
     GET https://api.themoviedb.org/3/trending/tv/day?api_key=YOUR_API_KEY&with_genres=16
     
     GET https://api.themoviedb.org/3/trending/tv/day?api_key=YOUR_API_KEY&with_genres=16
     
     
     https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc&first_air_date.gte=2023-01-01
     
     GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc&first_air_date.gte=2023-09-01
     
     */
    func getTrendingMoviesCatroon(completion :@escaping (Result<[Title], Error>)  -> Void){
        guard let url = URL(string: "\(Constants.getTrendingMoviesCatroonAPI)") else{return}
        //        must be view loader
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data,_,error in
            guard let data = data ,error == nil else{
                return
            }
            
            
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                //                print(results)
                //                print(results.results[0].original_title)
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    
    
    
    //    Get upcoming movies Cartoons
    /*
     GET GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&release_date.gte=2024-01-01&sort_by=release_date.asc
     
     GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&first_air_date.gte=2024-01-01&sort_by=first_air_date.asc
     
     
     */
    func getUpComingCartoons(completion :@escaping (Result<[Title], Error>) ->Void){
        
        //        GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=popularity.desc&first_air_date.gte=2023-01-01
        
        //        https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&first_air_date.gte=2024-11-01&sort_by=first_air_date.asc
        
        //        GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&first_air_date.gte=2024-11-01&sort_by=first_air_date.asc
        
        
        
        
        //        Discover Animated TV Shows for Kids (Emulating Trending)
        guard let url = URL(string: "\(Constants.upCompingCartoonAPI)")else{return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error  in
            guard let data = data , error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data )
                completion(.success(results.results))
                
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
        
    }
    
    
    
    //     get Pupular data
    /*
     GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=popularity.desc
     
     GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=popularity.desc
     
     
     
     GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&sort_by=popularity.desc
     
     
     
     */
    func getPopularCartoon(completion :@escaping (Result<[Title], Error>)  -> Void){
       
    
        
      
        guard let url = URL(string: "\(Constants.getPopularCartoonAPI)")else{return}
       
      

        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
         
       
            guard let data = data , error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
                
            }
        }
        task.resume()
        
    }
    
    func getComingSoonCartoons(completion :@escaping (Result<[Title], Error>)  -> Void){
        
        guard let url = URL(string: Constants.comingSoonCartoonsApi)else{return}
            let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
             
                    guard let data = data , error == nil else{
                        return
                    }
                    
                    do{
                        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                        completion(.success(results.results))
                        
                        
                    }catch{
                        completion(.failure(APIError.failedToGetData))
                        
                    }
                    
                    
                }
                task.resume()
            }
        
            
            
            //    TopRatedCartoons
            /*
             GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=vote_average.desc&vote_count.gte=500
             
             GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=vote_average.desc&vote_count.gte=500
             
             
             GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&sort_by=vote_average.desc&vote_count.gte=100
             
             */
            
            func getTopRatedCartoons(completion :@escaping (Result<[Title], Error>)  -> Void){
                //        GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=vote_average.desc&vote_count.gte=50
                
                //        toprated
                guard let url = URL(string: "\(Constants.getTopRatedAPI)")else{return}
                
                let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                    guard let data = data , error == nil else{
                        return
                    }
                    do{
                        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                        completion(.success(results.results))
                        
                        
                    }catch{
                        completion(.failure(APIError.failedToGetData))
                        
                    }
                    
                    
                    
                }
                
                task.resume()
            }
            func getDisneyCatroon(completion :@escaping (Result<[Title], Error>)  -> Void){
                
              LoaderViewController.sendRequest(url: Constants.DisneyCartoonsApi) { results in
                    
                    switch results{
                    case .success(let get):
                        completion(.success(get))
                    case.failure(let error):
                        completion(.failure(error))
                    }
                }
                //            do{
                //
                //                completion(.success(results.results))
                //                //                print(results)
                //                //                print(results.results[0].original_title)
                //            }catch{
                //                completion(.failure(APIError.failedToGetData))
                //            }
                //        }
                //
                
            }
            
            
            func getDiscoverResultsCartoons(completion :@escaping (Result<[Title], Error>)  -> Void){
                //        https://api.themoviedb.org/3/discover/tv?api_key=THE_KEY&language=en-US&page=1&with_genres=16&with_keywords=210024|287501&with_text_query=death
                /*
                 
                 GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&certification_country=US&certification.lte=G&with_watch_monetization_types=flatrate
                 
                 
                 GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&certification_country=US&certification.lte=G&with_watch_monetization_types=flatrate
                 
                 
                 GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&certification_country=US&certification.lte=G&with_watch_monetization_types=flatrate
                 
                 
                 GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&certification_country=US&certification.lte=G&with_watch_monetization_types=flatrate
                 
                 
                 
                 GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&certification_country=US&certification.lte=G
                 
                 url = "https://api.themoviedb.org/3/discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc&with_watch_monetization_types=flatrate"
                 
                 
                 https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&sort_by=vote_average.desc&vote_count.gte=50
                 
                 https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=G&first_air_date.gte=2024-11-01&sort_by=first_air_date.asc
                 
                 https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=35,12,878,14&sort_by=popularity.desc&language=en-US&primary_release_date.gte=2023-01-01&primary_release_date.lte=2023-12-31
                 
                 */
                
                
                guard let url = URL(string: "\(Constants.getDiscoverResultsCartoonsAPI)")else{
                    return
                }
                
                let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                    guard let data = data , error == nil else{
                        return
                    }
                    do{
                        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                        completion(.success(results.results))
                        
                        
                    }catch{
                        completion(.failure(APIError.failedToGetData))
                        
                    }
                    
                    
                    
                }
                
                task.resume()
            }
            
            //    curl --request GET \
            // .org/3/search/movie?query=Jack+Reacher&api_key=06b3d4ef4aa8a1338644921d5566ac0c'
            func search (with query:String, completion :@escaping (Result<[Title], Error>)  -> Void){
                
                guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
                guard let url = URL(string: "https://api.themoviedb.org/3/search/tv?query=\(query)&api_key=\(Constants.API_KEY)&with_genres=16,10751,35&language=en-US")else{
                    return
                }
                
                let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                    guard let data = data , error == nil else{
                        return
                    }
                    do{
                        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                        completion(.success(results.results))
                        
                        
                    }catch{
                        completion(.failure(APIError.failedToGetData))
                        
                    }
                    
                    
                    
                }
                
                task.resume()
                
            }
            func getMovie(with query :String , completion :@escaping (Result<VideoElemnts, Error>)  -> Void){
                //        GET https://www.googleapis.com/youtube/v3/search
                
                guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
                
                guard let url = URL(string: "\(Constants.youtube_Api_Base_URL)q=\(query)&key=\(Constants.youtube_Api_Key)")else{return}
                
                let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                    guard let data = data , error == nil else{
                        return
                    }
                    do{
                        let results = try JSONDecoder().decode( YoutubeSearchResponse.self, from: data )
                        completion(.success(results.items[0]))
                        
                        
                    }catch{
                        completion(.failure(error))
                        print(error.localizedDescription)
                    }
                }
                task.resume()
                
            }
        }
        //https://api.themoviedb.org/3/discover/tv
        //https://developer.themoviedb.org/reference/discover-tv
        
        
        
        //https://api.themoviedb.org/3/discover/movie?api_key=06b3d4ef4aa8a1338644921d5566ac0c&with_genres=16
        
        
        // Trending Movies Cartoon
        //https://api.themoviedb.org/3/trending/movie/week?api_key=YOUR_API_KEY&with_genres=16
        
        //Trending Cartoon (All Media Types):
        //https://api.themoviedb.org/3/trending/all/week?api_key=YOUR_API_KEY&with_genres=16
        
        // UpComing
        //https://api.themoviedb.org/3/movie/upcoming?api_key=YOUR_API_KEY&with_genres=16
        
        // Popular
        // https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY&with_genres=16
        
        // getTopRated
        //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY&with_genres=16
        
        
        
        
        
        /*
         GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=popularity.desc
         
         GET https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&certification_country=US&certification.lte=PG&sort_by=vote_average.desc&vote_count.gte=500
         
         */
    
