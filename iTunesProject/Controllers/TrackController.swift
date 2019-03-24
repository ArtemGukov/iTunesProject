//
//  QueryService.swift
//  iTunesProject
//
//  Created by Артем on 24/03/2019.
//  Copyright © 2019 Gukov.space. All rights reserved.
//

import UIKit

struct TrackController {
    
    let baseUrl = "https://itunes.apple.com/search?term="
    
    func fetchTracks(searchTerm: String, completion: @escaping ([Track]?) -> Void) {
    
        guard let urlTrack = URL(string: "\(baseUrl)"+"\(searchTerm)") else {
            completion(nil)
            print("URL is not correct")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlTrack) { (data, _, _) in
            guard let data = data else { return }
            guard let results = try? JSONDecoder().decode(Tracks.self, from: data) else { return }
            
            completion(results.results)
        }
        task.resume()
    }
}
