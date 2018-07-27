//
//  ViewController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit
import RxSwift


class HomeViewController: UIViewController {
    //MARK: Varijable za View
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 72)
        label.textColor = UIColor.white
        return label
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textColor = UIColor.white
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 36)
        label.textColor = UIColor.white
        label.text = "Grad"
        return label
    }()
    
    var minTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    var maxTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    var lowTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "Low"
        return label
    }()
    
    var highTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "High"
        return label
    }()
    
    var rainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "humidity_icon")
        return imageView
    }()
    
    var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "wind_icon")
        return imageView
    }()
    
    var pressureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pressure_icon")
        return imageView
    }()
    
    var rainChance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var windSpeed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var pressureIndicator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "settings_icon"), for: .normal)
        return button
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.white
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        let searchTextField: UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.leftView = nil
        searchTextField.placeholder = "Search"
        searchTextField.rightView = UIImageView(image: UIImage(named: "search_icon"))
        searchTextField.rightViewMode = UITextFieldViewMode.always
//        searchBar.gestureRecognizers = 
        return searchBar
    }()
    
    var stackViewMinMaxTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var stackViewLowHighTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var stackViewRainWindPressureImages: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var stackViewRainWindPressure: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var separatorLine: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.white
        return separator
    }()
    
    var bodyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var haxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "search_icon"), for: .normal)
        button.addTarget(self, action: #selector(openSearchScreen), for: .touchUpInside)
        return button
    }()
    
    
    
    let disposeBag = DisposeBag()
    var homeViewModel: HomeViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        initializeDataObservable()
        initializeErrorObservable()
        homeViewModel.initializeObservableWeatherDataAPI().disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViewModel.checkForWeatherData()
        
    }
    
    @objc func openSearchScreen(){
        print("Button taped")
        homeViewModel.openSearchScreen()
    }
    
    func setupView(){
        view.addSubview(headerImageView)
        headerImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(bodyImageView)
        bodyImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor).isActive = true
        bodyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bodyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
      
        view.addSubview(temperatureLabel)
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        
        view.addSubview(summaryLabel)
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive =  true
        summaryLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor).isActive = true
        
        view.addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(stackViewMinMaxTemperature)
        stackViewMinMaxTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewMinMaxTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewMinMaxTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewMinMaxTemperature.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        stackViewMinMaxTemperature.addArrangedSubview(minTemperature)
        stackViewMinMaxTemperature.addArrangedSubview(maxTemperature)
        
        view.addSubview(stackViewLowHighTemperature)
        stackViewLowHighTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewLowHighTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewLowHighTemperature.topAnchor.constraint(equalTo: stackViewMinMaxTemperature.bottomAnchor).isActive = true
        stackViewLowHighTemperature.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackViewLowHighTemperature.addArrangedSubview(lowTemperature)
        stackViewLowHighTemperature.addArrangedSubview(highTemperature)
        
        view.addSubview(stackViewRainWindPressureImages)
        stackViewRainWindPressureImages.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewRainWindPressureImages.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewRainWindPressureImages.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackViewRainWindPressureImages.addArrangedSubview(rainImageView)
        stackViewRainWindPressureImages.addArrangedSubview(windImageView)
        stackViewRainWindPressureImages.addArrangedSubview(pressureImageView)
        
        view.addSubview(stackViewRainWindPressure)
        stackViewRainWindPressure.topAnchor.constraint(equalTo: stackViewRainWindPressureImages.bottomAnchor).isActive = true
        stackViewRainWindPressure.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewRainWindPressure.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewRainWindPressure.addArrangedSubview(rainChance)
        stackViewRainWindPressure.addArrangedSubview(windSpeed)
        stackViewRainWindPressure.addArrangedSubview(pressureIndicator)
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: stackViewRainWindPressure.bottomAnchor, constant: 15).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: rainChance.trailingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: pressureIndicator.trailingAnchor, constant: -15).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: rainChance.centerXAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(separatorLine)
        separatorLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: stackViewMinMaxTemperature.topAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: stackViewLowHighTemperature.bottomAnchor).isActive = true
        
        view.addSubview(haxButton)
        haxButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        haxButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        haxButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        haxButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let weatherDataToDisplay = homeViewModel.weatherData
        pressureIndicator.text = "\(weatherDataToDisplay.pressure!) hpa"
        windSpeed.text = "\(weatherDataToDisplay.windSpeed!) mph"
        rainChance.text = "\(weatherDataToDisplay.humidity!)%"
        temperatureLabel.text = "\(weatherDataToDisplay.temperature!)°"
        minTemperature.text = "\(weatherDataToDisplay.temperatureMin!) °F"
        maxTemperature.text = "\(weatherDataToDisplay.temperatureMax!) °F"
        summaryLabel.text = weatherDataToDisplay.summary
        bodyImageView.image = weatherDataToDisplay.bodyImage
        headerImageView.image = weatherDataToDisplay.headerImage
        view.backgroundColor = weatherDataToDisplay.backgroundColor
        
        
        
    }
    
    func initializeDataObservable(){
        let dataObserver = homeViewModel.dataIsReady
        dataObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] event in
                if event {
                    self.setupView()
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    func initializeErrorObservable() {
        let errorObserver = homeViewModel.errorOccured
        errorObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (event) in
                if event {
                    ErrorController.alert(viewToPresent: self, title: "Greška!", message: "Ups, došlo je do pogreške")
                }
            })
            .disposed(by: disposeBag)
    }
    
}

