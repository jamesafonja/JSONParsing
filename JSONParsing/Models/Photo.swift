//
//  Photo.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import Foundation

struct Photo: Codable, Identifiable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
