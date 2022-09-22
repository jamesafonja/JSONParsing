//
//  PhotoListRowView.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import SwiftUI

struct PhotoListRowView: View {
    @State private var id: Int
    @State private var url: URL?
    @State private var title: String
    
    init(id: Int, photoUrl: String, title: String) {
        _id = State(wrappedValue: id)
        _url = State(wrappedValue: URL(string: photoUrl) ?? nil)
        _title = State(wrappedValue: title)
    }

    var body: some View {
        HStack(spacing: 15) {
            Text(String(id))
                .bold()
            
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            
            Text(title)
                .font(.subheadline)
                .bold()
                .lineLimit(3)
                .frame(alignment: .leading)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
            Color.white
                .cornerRadius(15)
                .shadow(
                    color: .gray.opacity(0.5),
                    radius: 3,
                    x: 2,
                    y: 2)
        )
    }
}

struct PhotoListRowView_Previews: PreviewProvider {
    @State static var id = 3
    @State static var photoUrl = "https://via.placeholder.com/150/f66b97"
    @State static var title: String = "test"
    
    static var previews: some View {
        ZStack {
            Color.white
            
            PhotoListRowView(id: id, photoUrl: photoUrl, title: title)
        }
    }
}
