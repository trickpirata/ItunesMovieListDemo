//
//  MovieListViewController.swift
//  ItunesMovieListTest
//
//  Created by Patrick Gorospe on 1/22/18.
//  Copyright © 2018 Patrick Gorospe. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import AlamofireImage

class MovieListViewController: UIViewController {

    @IBOutlet weak var tblMovieList: UITableView!
    
    private var dataSource = [[String: String]]()
    
    private let URL = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HUD.dimsBackground = true
        getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getMovies() {
        HUD.show(.progress, onView: view)
        Alamofire.request(URL).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value as? [String:Any] {
                if let f = json["feed"] as? [String:Any], let entry = f["entry"] as? [[String:Any]]{
                    for m in entry {
                        let title = m["im:name"] as! [String:String]
                        let summary = m["summary"] as! [String:String]
                        let price = m["im:price"] as! [String:Any]
                        let releaseDate = m["im:releaseDate"] as! [String:Any]
                        let link = m["id"] as! [String:Any]
                        
                        var movieInfo = [String:String]()
                        movieInfo["title"] = title["label"]
                        movieInfo["summary"] = summary["label"]
                        movieInfo["price"] = price["label"] as? String
                        movieInfo["link"] = link["label"] as? String
                        
                        if let images = m["im:image"] as? [[String:Any]] {
                            if let i = images.last {
                                movieInfo["image"] = i["label"] as? String
                            }
                        }
                        
                        if let d = releaseDate["attributes"] as? [String:String] {
                            movieInfo["release"] = d["label"]
                        }
                        
                        self.dataSource.append(movieInfo)
                    }
                }
            }
            
            self.tblMovieList.reloadData()
            HUD.hide(animated: true)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! MovieDetailsViewController
        vc.movieInfo = sender as? [String:String]
    }
 

}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movieInfo = dataSource[indexPath.row]
        
        cell.txtPrice.text = movieInfo["price"]
        cell.txtTitle.text = movieInfo["title"]
        cell.txtReleaseDate.text = movieInfo["release"]

        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = dataSource[indexPath.row]
        
        tblMovieList.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "MovieDetailsViewController", sender: selectedMovie)
    }
    
}
