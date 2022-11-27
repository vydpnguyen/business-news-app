//
//  ContentView.swift
//  Business News App
//
//  Created by Vy Dang Phuong Nguyen on 11/27/22.
//

import SwiftUI

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

struct ContentView: View {
    
    @State private var articles = [Article]()

    var body: some View {
      
        NavigationView {
            List(articles, id:\.self) {
                article in
                VStack(alignment: .leading) {
                    Text(article.title!)
                    Text(article.author!)
                        .bold()
                }
            }
        }
        .navigationTitle("Headlines")
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=bcf851953bbb43b9b8cb414e79e4932a") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let news = try? JSONDecoder().decode(News.self, from: data) {
                self.articles = news.articles!
            }
        }
        catch {
            print("Cannot parse JSON")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
