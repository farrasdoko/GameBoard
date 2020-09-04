//
//  ViewController.swift
//  GameBoard
//
//  Created by Farras Doko on 19/07/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbGame: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var tableHeader: UILabel!
    var popularGame: PGPopGame?
    var temporaryData: [FavGameModel] = []
    var games: [FavGameModel] = []
    
    private lazy var provider: CDProvider = { return CDProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tbGame.delegate = self
        tbGame.dataSource = self
        
        startSync()
        provider.getData {
            self.temporaryData = $0
        }
    }
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tableHeader.text = "Most Popular Game"
            
            guard let results = popularGame?.results else {return}
            games.removeAll()
            for obj in results {
                guard let id = obj.id else { fatalError("id not found") }
                
                let game = FavGameModel(
                    id: Int32(id),
                    image: nil,
                    title: obj.name,
                    publisher: nil,
                    year: obj.released,
                    platforms: nil,
                    site: nil,
                    genre: convertGenre(from: obj.genres),
                    body: nil,
                    rating: obj.rating
                )
                games.append(game)
            }
            self.tbGame.reloadData()
            
            break
        case 1:
            // if data isn't complete but the user click segmented. Force stop loading and show table.
            tbGame.isHidden = false
            loading.stopAnimating()
            tableHeader.text = "Your Favorite Game"
            
            games.removeAll()
            provider.getData { favoriteGames in
                self.games = favoriteGames
                self.temporaryData = favoriteGames
                
                DispatchQueue.main.async {
                    self.tbGame.reloadData()
                }
            }
            
            break
        default:
            break
        }
    }
    
    fileprivate func startSync() {
        
        guard let url = URL(string: "https://api.rawg.io/api/games") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, err in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            
            if response.statusCode == 200 {
                self.decodeJSON(data: data)
            } else {
                let alert = UIAlertController(title: "error", message: "error with code \(response.statusCode)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            }
        }
        task.resume()
    }
    
    private func decodeJSON(data: Data) {
        let decoder = JSONDecoder()
        let popGame = try? decoder.decode(PGPopGame.self, from: data)
        
        popularGame = popGame
        guard let results = popGame?.results else {return}
        
        DispatchQueue.main.async {
            guard self.segmented.selectedSegmentIndex != 1 else {
                return
            }
            
            self.games.removeAll()
            for obj in results {
                guard let id = obj.id else { fatalError("can't find id") }
                
                let game = FavGameModel(
                    id: Int32(id),
                    image: nil,
                    title: obj.name,
                    publisher: nil,
                    year: obj.released,
                    platforms: nil,
                    site: nil,
                    genre: convertGenre(from: obj.genres),
                    body: nil,
                    rating: obj.rating
                )
                self.games.append(game)
            }
            
            self.tbGame.isHidden = false
            self.tbGame.reloadData()
            self.loading.stopAnimating()
        }
    }
    
}

extension ViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbGame.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameCell
        
        let preview = popularGame?.results?[indexPath.row].clip?.preview
        let item = CellViewModel(item: games[indexPath.row], ImageUrl: preview)
        
        cell.context = item
        
        if let image = item.image {
            cell.img.image = image
        } else {
            if let clip = preview, let url = URL(string: clip) {
                // force unwrap used because image surely exist (local image)
                cell.img.imageFrom(url: url, blankImage: UIImage(named: "cellImg")!)
            } else {
                // force unwrap used because image surely exist (local image)
                let url = URL(string: "blankimage.com")
                cell.img.imageFrom(url: url!, blankImage: UIImage(named: "cellImg")!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {
            return
        }
        
        let object = temporaryData.filter { $0.id == games[indexPath.row].id }
        if object.count != 0 {
            detailController.parsed = object.first
        } else {
            detailController.parsed = games[indexPath.row]
            
        }
        detailController.refreshData = self
        if segmented.selectedSegmentIndex == 1 {
            detailController.refreshTable = true
        }
        
        self.navigationController?.pushViewController(detailController, animated: false)
        self.tbGame.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Refresh Data Parent
extension ViewController: UpdateParent {
    func refreshData(refreshTable: Bool) {
        provider.getData {
            self.temporaryData = $0
            if refreshTable {
                self.games.removeAll()
                self.games = $0
                DispatchQueue.main.async {
                    self.tbGame.reloadData()
                }
            }
        }
    }
}
