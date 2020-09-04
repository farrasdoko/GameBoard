//
//  DetailViewController.swift
//  GameBoard
//
//  Created by Farras Doko on 20/07/20.
//  Copyright © 2020 dicoding. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var gameYear: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var bodyHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyWeb: WKWebView!
    @IBOutlet weak var platformTxt: UILabel!
    @IBOutlet weak var site: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var parsed: FavGameModel? //{
//        didSet {
//            gameName.text = parsed?.title
//            gameYear.text = "(\(parsed?.year?.year() ?? ""))"
//            genre.text = parsed?.genre
//
//            publisher.text = parsed?.publisher
//            bodyWeb.loadHTMLString(parsed?.body ?? "", baseURL: nil)
//            site.setTitle(parsed?.site, for: .normal)
//            platformTxt.text = parsed?.platforms
//        }
//    }
    private lazy var provider: CDProvider = { return CDProvider() }()
    var body = ""
    var rate: Float = 0
    private var imageDownloaded = false
    var refreshData: UpdateParent?
    var refreshTable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gameName.text = parsed?.title
        gameYear.text = parsed?.year?.year()
        genre.text = parsed?.genre
        
        bodyWeb.navigationDelegate = self
        bodyWeb.scrollView.bounces = false
        
        
        // set data from core data if available
        if let image = parsed?.image {
            publisher.text = parsed?.publisher
            bodyWeb.loadHTMLString(parsed?.body ?? "", baseURL: nil)
            site.setTitle(parsed?.site, for: .normal)
            
            site.isEnabled = true
            platformTxt.text = parsed?.platforms
            img.image = UIImage(data: image)
            imageDownloaded = true
            
            favoriteButton.isHidden = false
            favoriteButton.removeBorder()
        } else {
            // set if the page is loading
            publisher.text = "Please Wait..."
            bodyHeight.constant = 0
            site.setTitle("www....net", for: .normal)
            site.isEnabled = false
            platformTxt.text = ""
            favoriteButton.isHidden = true
            
            startSync()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        refreshData?.refreshData(refreshTable: refreshTable)
    }
    
    @IBAction func openSite(_ sender: UIButton) {
        guard let path = site.titleLabel?.text, let url = URL(string: path) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func addToFav(_ sender: UIButton) {
        func process() {
            guard let id = parsed?.id, let image = img.image?.jpegData(compressionQuality: 1.0), let title = parsed?.title, let publisher = publisher.text, let year = parsed?.year, let platforms = platformTxt.text, let site = site.titleLabel?.text, let genre = parsed?.genre else {
                defaultAlert("error", "Data isn't complete / synced.")
                return
            }
            if sender.titleLabel?.text?.lowercased() == "remove from favorite" {
                provider.deleteData(Int(id)) {
                    DispatchQueue.main.async {
                        self.favoriteButton.addBorder()
                    }
                }
            } else {
                provider.createData(id: Int(id), image, title, publisher, year, platforms, site, genre, body, rate) {
                    DispatchQueue.main.async {
                        self.favoriteButton.removeBorder()
                    }
                }
            }
        }
//        let pathUrl = URL(string: "https://media.rawg.io/media/stories/a30/a3017aa7740f387a158cbc343524275b.mp4")!
//        let player = AVPlayer(url: pathUrl)
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        self.present(playerController, animated: true) {
//            playerController.player?.play()
//        }
        if !imageDownloaded {
            let alert = UIAlertController(title: "", message: "Image is still downloading, are you sure want to save without image?", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                process()
            })
            let no = UIAlertAction(title: "No", style: .cancel)
            for action in [yes, no] {
                alert.addAction(action)
            }
            present(alert, animated: true)
        } else {
            process()
        }
    }
    
    func defaultAlert(_ title: String,_ msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    fileprivate func startSync() {
        guard let ID = parsed?.id, let url = URL(string: "https://api.rawg.io/api/games/\(ID)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, err in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            
            if response.statusCode == 200 {
                self.decodeJSON(data: data)
            } else {
                let alert = UIAlertController(title: "error", message: "error with code \(response.statusCode)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    private func decodeJSON(data: Data) {
        let decoder = JSONDecoder()
        guard let detail = try? decoder.decode(DtDetailBody.self, from: data) else { return }
        let description = detail.descriptionValue ?? "No data available or check your connection"
        let body = "<html><meta name=\"viewport\" content=\"initial-scale=1, user-scalable=no, width=device-width\" /><body>" + description + "</body></html>"
        self.body = body
        self.rate = detail.rating ?? 0
        
        DispatchQueue.main.async {
            if let publisher = detail.publishers?.first?.name {
                self.publisher.text = publisher
            } else {
                self.publisher.text = "Unknown"
            }
            self.bodyWeb.loadHTMLString(body, baseURL: nil)
            self.site.setTitle(detail.website, for: .normal)
            self.site.isEnabled = true
            self.platformTxt.text = self.getPlatform(detail.platforms)
            if let url = URL(string: detail.backgroundImage ?? "") {
            // force unwrap image because image surely exist (local image)
                self.img.imageFrom(url: url, blankImage: UIImage(named: "profile_ex")!, completion: {
                    self.imageDownloaded = true
                })
            }
            
            self.favoriteButton.isHidden = false
            self.favoriteButton.addBorder()
        }
    }
    
    private func getPlatform(_ pf: [DtPlatforms]?) -> String {
        guard let platforms = pf else {return ""}
        var platform = ""
        for (i,p) in platforms.enumerated() {
            platform.append(p.platform?.name ?? "")
            if i < (platforms.count - 1) {
                platform.append(", ") }
        }
        return platform
    }
    
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.bodyWeb.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.bodyWeb.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                    if let height = height {
                        self.bodyHeight.constant = height as? CGFloat ?? 0
                    }
                })
            }
            
        })
    }
}
