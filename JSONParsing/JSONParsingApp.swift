//
//  JSONParsingApp.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import SwiftUI

@main
struct JSONParsingApp: App {
    @StateObject var apiHandler: APIHandler = APIHandler()

    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(apiHandler)
        }
    }
}
