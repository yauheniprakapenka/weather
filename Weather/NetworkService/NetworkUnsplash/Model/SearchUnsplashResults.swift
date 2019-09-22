//
//  SearchResult.swift
//  Weather
//
//  Created by yauheni prakapenka on 08/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

struct SearchUnsplashResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue:String]
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
}
