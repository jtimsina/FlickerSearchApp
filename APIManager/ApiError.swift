//
//  ApiError.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/6/25.
//
import Foundation
enum ApiError:Error {
    case invalidRequest
    case apiError
    case dataNotFound
    case responseError
    case parsingError
    case invalidResponse
}
