//
//  YoutubeSearchResponse.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 07/11/2024.
//

import Foundation
import UIKit

struct YoutubeSearchResponse :Codable {
    let items :[VideoElemnts]
    
}
struct VideoElemnts :Codable {
    
    let id :IdVideoElement
    
}
struct IdVideoElement :Codable {
    let kind :String
    let videoId : String
}
/*
 items =     (
             {
         etag = "r-m0y-IVuXbnh8Ydr_SomeC7Vxs";
         id =             {
             kind = "youtube#video";
             videoId = gRjKAcJauk4;
         };
         kind = "youtube#searchResult";
     },
 */
