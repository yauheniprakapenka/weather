//
//  NetworkDataFetcher.swift
//  Weather
//
//  Created by yauheni prakapenka on 08/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

class NetworkDataFetcherUnsplash {
    
    let networkService = NetworkServiceUnsplash()
    
    func downloadImage(searchTerm: String, completion: @escaping (SearchUnsplashResults?) -> ()) {
        
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchUnsplashResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
