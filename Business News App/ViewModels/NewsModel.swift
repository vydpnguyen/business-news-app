//
//  NewsModel.swift
//  Business News App
//
//  Created by Vy Dang Phuong Nguyen on 11/27/22.
//

import Foundation

class NewsModel: ObservableObject {
    
    @Published var articles = [Article]()
    
}
