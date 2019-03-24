//
//  TracksTableViewController.swift
//  iTunesProject
//
//  Created by Артем on 24/03/2019.
//  Copyright © 2019 Gukov.space. All rights reserved.
//

import UIKit

class TracksTableViewController: UITableViewController {

    let trackControler = TrackController()
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter track"
        navigationItem.searchController = searchController
    }
    
    func fetchData() {
        let searchTerm = navigationItem.searchController?.searchBar.text ?? ""
        if !searchTerm.isEmpty {
            trackControler.fetchTracks(searchTerm: searchTerm, completion: { (tracks) in
                if let tracks = tracks {
                    self.tracks = tracks
                
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            } else {
                print("No data")
                }
            })
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let result = tracks[indexPath.row]
        
        cell.textLabel?.text = result.artistName
        cell.detailTextLabel?.text = result.trackName
        
        if let imageData = try? Data(contentsOf: result.artworkUrl100) {
            let image = UIImage(data: imageData)
            cell.imageView?.image = image
            }
    return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TracksTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        fetchData()
    }
}
