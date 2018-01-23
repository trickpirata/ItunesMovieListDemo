//
//  MovieDetailsViewController.swift
//  ItunesMovieListTest
//
//  Created by Patrick Gorospe on 1/22/18.
//  Copyright © 2018 Patrick Gorospe. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movieInfo:[String:String]?
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        if let m = movieInfo {
            lblTitle.text = m["title"]
            lblPrice.text = m["price"]
            lblRelease.text = m["release"]
            
            if let url = URL(string: m["image"]!) {
                imgPoster.af_setImage(withURL: url)
            }
        }
    }
    
    @IBAction func btnClose_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOpen_action(_ sender: Any) {
        if let m = movieInfo,let url = m["link"], let u = URL(string: url) {
            
            UIApplication.shared.open(u, options: [:], completionHandler: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
