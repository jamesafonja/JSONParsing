//
//  MainView.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var apiHandler: APIHandler
    
    var body: some View {
        TabView {
            NavigationView {
                TodoListView()
                // Dependency injection using environment object
                    .environmentObject(apiHandler)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Todos", systemImage: "list.bullet")
            }

            NavigationView {
                PhotoListView()
                    .navigationTitle("Photos")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Photos", systemImage: "photo")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
