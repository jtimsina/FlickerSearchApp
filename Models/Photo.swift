//
//  Photo.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/5/25.
//
import Foundation

struct FlickrResponse: Codable {
    let items: [Photo]
}

struct Photo: Codable, Identifiable {
    var id: String { link }
    let title: String
    let media: Media
    let author: String
    let description: String
    let published: String
    let link: String
}

struct Media: Codable {
    let m: String
}
