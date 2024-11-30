//
//  Constants.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 16/11/2024.
//

import Foundation
import UIKit
struct Constants {
    
    
    static let API_KEY = "06b3d4ef4aa8a1338644921d5566ac0c"
    static let base_URL = "https://api.themoviedb.org"
    static let youtube_Api_Key = "AIzaSyD7DElrFFIUZzlH12m-tH31lVWanRlX7FE"
    static let youtube_Api_Base_URL = "https://www.googleapis.com/youtube/v3/search?"
    //    Comedy
    static let getTrendingMoviesAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=16,35&certification_country=US&certification.lte=PG&sort_by=popularity.desc"
    //    https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=12,16&sort_by=popularity.desc
    // Adanture
    static let getTrendingMoviesCatroonAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=12,16&sort_by=popularity.desc"
    
    //    https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=14&certification_country=US&certification.lte=G
    //Fantecy
    static let upCompingCartoonAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=14,16&certification_country=US&certification.lte=G"
    
    
    // sifi
    static let getPopularCartoonAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=16,878&sort_by=popularity.desc"
//    Action
    //     Top Rated
//    GET https://api.themoviedb.org/3/discover/tv?api_key=YOUR_API_KEY&with_genres=16,10751&with_keywords=fight&certification_country=US&certification.lte=G&sort_by=popularity.desc
//curl -X GET "https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16,10751&with_keywords=fight,kung-fu,superhero&certification_country=US&certification.lte=G&sort_by=popularity.desc"

// https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=28,12&sort_by=popularity.desc

//https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&release_date.gte=2024-11-20&sort_by=release_date.asc

    static let getTopRatedAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=16,10751,28&certification_country=US&certification.lte=G&sort_by=popularity.desc"
//    https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_genres=16&release_date.gte=2024-11-20&sort_by=release_date.asc

    static let comingSoonCartoonsApi = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=16,10751&release_date.gte=2024-11-20&sort_by=release_date.asc"
    
    //      Disney
//    https://api.themoviedb.org/3/discover/movie?api_key=06b3d4ef4aa8a1338644921d5566ac0c&with_companies=2&with_genres=16,10751&certification_country=US&certification.lte=G&sort_by=popularity.desc
    static let DisneyCartoonsApi = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_companies=2&with_genres=16,10751&certification_country=US&certification.lte=G&sort_by=popularity.desc"
    
    static let getDiscoverResultsCartoonsAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=16,10751&sort_by=popularity.desc&language=en-US&primary_release_date.gte=2023-01-01&primary_release_date.lte=2024-11-1"
    
    
    
    

}
