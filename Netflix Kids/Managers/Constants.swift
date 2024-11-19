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
    
    //     Top Rated
    
    static let getTopRatedAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=35,12,878,12,16sort_by=vote_average.desc&vote_count.gte=1000"
    
    static let comingSoonCartoonsApi = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=35,12,878,14,16&primary_release_date.gte=2020-01-01&sort_by=primary_release_date.asc&region=US&language=en-US"
    
    //      Disney
    static let DisneyCartoonsApi = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_companies=6125&with_genres=16"
    
    static let getDiscoverResultsCartoonsAPI = "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=35,12,878,14,16&sort_by=popularity.desc&language=en-US&primary_release_date.gte=2023-01-01&primary_release_date.lte=2023-12-31"
    
    
    
    

}
