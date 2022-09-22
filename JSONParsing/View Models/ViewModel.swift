//
//  ViewModel.swift
//  JSONParsing
//
//  Created by Revive on 9/20/22.
//

import Foundation

protocol ViewModel {
    var service: DataService { get }
    var statusMessage: String { get }
    var hasError: Bool { get }
}
