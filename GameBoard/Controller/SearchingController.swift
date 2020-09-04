//
//  SearchingController.swift
//  GameBoard
//
//  Created by Farras Doko on 18/08/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

class SearchingController: UITableViewController {
    
    var result: [PGResults]?
    var temporaryData: [FavGameModel] = []
    
    lazy var provider: CDProvider = { return CDProvider() }()
    lazy var loading: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        v.color = .systemRed
        v.hidesWhenStopped = true
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        provider.getData { (games) in
            self.temporaryData = games
        }
    }
    
    // search func
    func search(for query: String?) {
        var path = URLComponents(string: "https://api.rawg.io/api/games")
        path?.queryItems = [ URLQueryItem(name: "search", value: query) ]
        guard let url = path?.url else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else {
                self.displaySearchError(error)
                return
            }
            self.result = data?.decoderPopGame(from: data)?.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loading.stopAnimating()
            }
        }
        task.resume()
    }
    
    private func displaySearchError(_ error: Error?) {
        if let error = error as NSError?, let errorString = error.userInfo[NSLocalizedDescriptionKey] as? String {
            let alertController = UIAlertController(title: "Can't find any games.", message: errorString, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        let item = result?[indexPath.row]
        
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = item?.released
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {
            return
        }
        let item = result?[indexPath.row]
        
        guard let id = result?[indexPath.row].id else { fatalError("Can't find id") }
        let object = temporaryData.filter { $0.id == Int32(id) }
        
        if object.count != 0 {
            detailController.parsed = object.first
        } else {
            let favGame = FavGameModel(id: Int32(id), image: nil, title: item?.name, publisher: nil, year: item?.released?.year(), platforms: nil, site: nil, genre: convertGenre(from: item?.genres), body: nil, rating: item?.rating)
            detailController.parsed = favGame
        }
        
        navigationController?.pushViewController(detailController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SearchingController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        dismiss(animated: true, completion: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loading)
        loading.startAnimating()
        search(for: searchBar.text)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
