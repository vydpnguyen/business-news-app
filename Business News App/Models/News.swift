//
//  News.swift
//  Business News App
//
//  Created by Vy Dang Phuong Nguyen on 11/27/22.
//

import Foundation

struct News: Hashable, Codable {
    var status:String
    var totalResults:Int
    var articles:[Article]?
}

struct Article: Hashable, Codable {
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
}
