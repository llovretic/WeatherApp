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

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tableViewSearch: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect )
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
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
        let searchTextField = searchBar.value(forKey: "searchField") as! UITextField
        searchTextField.leftView = nil
        searchTextField.placeholder = "Search"
        searchTextField.rightView = UIImageView(image: UIImage(named: "search_icon"))
        return searchBar
    }()
    
    let cellIdentifier = "CellID"
    var searchViewModel: SearchViewModel!
    let disposeBag = DisposeBag()
    let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    var searchCoordinatorDelegate: DissmissCoordinatorDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        searchViewModel.initializeObservableCityDataAPI().disposed(by: disposeBag)
        tableViewSearch.register(CityTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        addBlurEffectToBackground()
        setupView()
        searchBar.becomeFirstResponder()
        tableViewSearch.dataSource = self
        tableViewSearch.delegate = self
        searchBar.delegate = self
        initializeDataObservable()
        initializeLoaderObservable()
        initializeErrorObservable()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    deinit {
        print("Single News deinit")
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.city.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CityTableViewCell else {
            return UITableViewCell()
    }
        let dataToDisplay = searchViewModel.city[indexPath.row]
        cell.cityLabel.text = dataToDisplay.cityName
        cell.cityLetterLabel.text = String(describing: dataToDisplay.cityName!.first!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel.selectedCityData(selectedCity: indexPath.row)
    }
    
    func addBlurEffectToBackground(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.cityName = searchBar.text
        searchViewModel.downloadTrigger.onNext(true)
    }
    
    func initializeDataObservable(){
        let observer = searchViewModel.dataIsReady
        observer
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                
                if event {
                    self.loadingIndicator.stopAnimating()
                    self.tableViewSearch.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func initializeErrorObservable() {
        let errorObserver = searchViewModel.errorOccured
        errorObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {  [unowned self] (event) in
                if event {
                    ErrorController.alert(viewToPresent: self, title: "Greška!", message: "Ups, dogodila se greška!")
                    self.loadingIndicator.stopAnimating()
                } else {
                }
            })
            .disposed(by: disposeBag)
    }
    
    func initializeLoaderObservable() {
        let loadingObserver = searchViewModel.loaderControll
        loadingObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                if (event) {
                    self.loadingIndicator.center = self.view.center
                    self.loadingIndicator.color = UIColor.black
                    self.view.addSubview(self.loadingIndicator)
                    self.view.bringSubview(toFront: self.loadingIndicator)
                    self.loadingIndicator.startAnimating()
                }
                else {
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.removeFromSuperview()
                }
            })
            .disposed(by: disposeBag)
    }
}
