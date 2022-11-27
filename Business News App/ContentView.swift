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
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    Text("Headlines")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 30)
                    
                    Text("From TechCrunch Right Now")
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                    
                    ScrollView {
                        
                        LazyVStack(alignment: .leading) {
                            
                            ForEach(articles, id: \.self) { article in
                                
                                NavigationLink(
                                    destination: WebView(url: URL(string: article.url!)!),
                                    label: {
                                        HStack(alignment: .top) {
                                            
                                            ImageView(url: URL(string: article.urlToImage!)!)
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .clipped()
                                                .cornerRadius(10)
                                                .padding(.bottom, 20)
                                            
                                            VStack(alignment: .leading) {
                                                
                                                Text(article.title!)
                                                    .multilineTextAlignment(.leading)
                                                    .bold()
                                                    .foregroundColor(Color.white)
                                                
                                                // Spacer()
                                                
                                                Text("By \(article.author!)")
                                                    .padding(.top, 2)
                                                    .foregroundColor(Color.gray)
                                                
                                                //Spacer()
                                            }
                                            .padding(10)
                                        }
                                    })
                            }
                        }
                        .accentColor(Color.black)
                        .padding(17)
                    }
                    
                }
            }
        }
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
