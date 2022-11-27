//
//  ImageView.swift
//  Business News App
//
//  Created by Vy Dang Phuong Nguyen on 11/27/22.
//

import SwiftUI

struct ImageView: View {
    
    var url: URL
    
    var body: some View {
        Image(systemName: "person.fill")
            .data(url: url)
            .resizable()

    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: URL(string: "https://static.timesofisrael.com/www/uploads/2022/08/000_32HA39P-e1661772133287-1024x640.jpg")!)
    }
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
