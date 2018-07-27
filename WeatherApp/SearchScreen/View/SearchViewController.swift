//
//  ScreenViewController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewSearch: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_uncheck"), for: .normal)
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pressedCancelButton), for: .touchUpInside)
        return button
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.white
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        
        return searchBar
    }()
    
    let cellIdentifier = "CellID"
    var searchViewModel: SearchViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.initializeObservableCityDataAPI().disposed(by: disposeBag)
        tableViewSearch.register(CityTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setupView()
        view.backgroundColor = UIColor.lightGray
        searchBar.becomeFirstResponder()
        tableViewSearch.dataSource = self
        tableViewSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("!WTF! u appearu")
        searchViewModel.triggerGeoDownload()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CityTableViewCell else {
            return UITableViewCell()
    }
        cell.cityImageView.image = UIImage(named: "checkmark_uncheck")
        cell.cityLabel.text = "London"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func setupView() {
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(searchBar)
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -230).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(tableViewSearch)
        tableViewSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableViewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewSearch.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8).isActive = true
        tableViewSearch.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -8).isActive = true
    }
    
    @objc func pressedCancelButton(){
        searchViewModel.cancelSearchViewController()
    }


}
