//
//  Post.swift
//  JSONParsing
//
//  Created by Revive on 9/19/22.
//

import Foundation

struct Todo: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
