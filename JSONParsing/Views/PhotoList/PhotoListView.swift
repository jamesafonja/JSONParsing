//
//  PhotoListView.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject private var vm: PhotoListViewModel
    
    init() {
        let vm = PhotoListViewModel(service: APIHandler())
        _vm = StateObject(wrappedValue: vm)
        
        vm.getPhotos(from: vm.photosUrlString) { success in
            // Perform additional actions
        }
    }
        
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.photos) { photo in
                    PhotoListRowView(
                        id: photo.id,
                        photoUrl: photo.thumbnailUrl,
                        title: photo.title
                    )
                        .padding(.horizontal, 10)
                }
            }
        }
        .navigationTitle("Photos")
        .alert(isPresented: $vm.hasError) {
            Alert(
                title: Text("Error"),
                message: Text(vm.statusMessage)
            )
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
