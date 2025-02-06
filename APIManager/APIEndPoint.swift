//
//  APIEndPoint.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/6/25.
//

import Foundation

struct APIEndPoint{
    static func getAPIEndPoint(searchText:String) ->String{
        let formattedText = searchText.replacingOccurrences(of: " ", with: ",")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(formattedText)"

        return urlString
    }
}
