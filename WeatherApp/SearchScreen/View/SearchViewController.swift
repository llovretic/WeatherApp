//
//  ScreenViewController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var searchViewModel: SearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return
    }
    



}
