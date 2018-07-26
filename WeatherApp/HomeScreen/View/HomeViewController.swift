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
        label.font = UIFont(name: "AvenirNext-medium", size: 72)
        label.text = "27"
        return label
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 24)
        label.text = "Vrijeme"
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 36)
        label.text = "Grad"
        return label
    }()
    
    var minTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 24)
        label.textAlignment = .center
        label.text = "min"
        return label
    }()
    
    var maxTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 24)
        label.textAlignment = .center
        label.text = "max"
        return label
    }()
    
    var lowTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 20)
        label.textAlignment = .center
        label.text = "Low"
        return label
    }()
    
    var highTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 20)
        label.textAlignment = .center
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
        label.font = UIFont(name: "AvenirNext-medium", size: 20)
        label.text = "rain"
        label.textAlignment = .center
        return label
    }()
    
    var windSpeed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 20)
        label.text = "wind"
        label.textAlignment = .center
        return label
    }()
    
    var pressureIndicator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-medium", size: 20)
        label.text = "pressure"
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
        stackView.distribution = .fillProportionally
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
  
    
    let disposeBag = DisposeBag()
    var homeViewModel = HomeViewModel()
    
    
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

    func setupView(){
        view.addSubview(bodyImageView)
        bodyImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bodyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bodyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bodyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        view.addSubview(headerImageView)
        headerImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(temperatureLabel)
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
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
        
        let WeatherInfo = homeViewModel.weatherData
        pressureIndicator.text = "\(WeatherInfo.pressure) hpa"
        windSpeed.text = "\(WeatherInfo.windSpeed) mph"
        rainChance.text = "\(WeatherInfo.humidity)%"
        temperatureLabel.text = "\(WeatherInfo.temperature)°"
        minTemperature.text = "\(WeatherInfo.temperatureMin) °F"
        maxTemperature.text = "\(WeatherInfo.temperatureMax) °F"
        summaryLabel.text = WeatherInfo.summary
        
        
    }
    
    func initializeDataObservable(){
        let dataObserver = homeViewModel.dataIsReady
        dataObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] event in
                if event {
                    self.setupView()
                    print(self.homeViewModel.weatherData)
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

