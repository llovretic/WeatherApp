//
//  ViewController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit
import RxSwift


class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
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
    
    var humidityPercent: UILabel = {
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
        button.addTarget(self, action: #selector(openSettingsScreen), for: .touchUpInside)
        return button
    }()
    
    var searchBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "search_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var searchLabel: UILabel = {
        let search = UILabel()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.text = "Search"
        search.textColor = UIColor.lightGray
        return search
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
        button.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0)
        button.addTarget(self, action: #selector(openSearchScreen), for: .touchUpInside)
        return button
    }()
    
    let disposeBag = DisposeBag()
    var homeViewModel: HomeViewModel!
    let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.initializeObservableWeatherDataAPI().disposed(by: disposeBag)
        initializeDataObservable()
        initializeErrorObservable()
        initializeLoaderObservable()
        homeViewModel.initializeSettingsConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.homeViewModel.checkForWeatherData()
    }
    
    @objc func openSearchScreen(){
        homeViewModel.openSearchScreen()
    }
    @objc func openSettingsScreen(){
        homeViewModel.openSettingsScreen()
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
        stackViewRainWindPressure.addArrangedSubview(humidityPercent)
        stackViewRainWindPressure.addArrangedSubview(windSpeed)
        stackViewRainWindPressure.addArrangedSubview(pressureIndicator)
        
        
        view.addSubview(separatorLine)
        separatorLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: stackViewMinMaxTemperature.topAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: stackViewLowHighTemperature.bottomAnchor).isActive = true
        
        view.addSubview(searchBarView)
        searchBarView.topAnchor.constraint(equalTo: stackViewRainWindPressure.bottomAnchor, constant: 16).isActive = true
        searchBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: lowTemperature.centerXAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        searchBarView.addSubview(haxButton)
        haxButton.topAnchor.constraint(equalTo: stackViewRainWindPressure.bottomAnchor, constant: 16).isActive = true
        haxButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        haxButton.leadingAnchor.constraint(equalTo: lowTemperature.centerXAnchor).isActive = true
        haxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        haxButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchBarView.addSubview(searchLabel)
        searchLabel.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 12).isActive = true
        searchLabel.topAnchor.constraint(equalTo: searchBarView.topAnchor).isActive = true
        searchLabel.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        
        searchBarView.addSubview(searchImageView)
        searchImageView.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -8).isActive = true
        searchImageView.topAnchor.constraint(equalTo: searchBarView.topAnchor).isActive = true
        searchImageView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        
    }
    
    func getWeatherDataToDisplay() {
        let settingsConfiguration = homeViewModel.settingsConfiguration
        let weatherDataToDisplay = self.homeViewModel.weatherData
        
        
        if (settingsConfiguration?.unit  == UnitSystem.Imperial.value ){
            self.temperatureLabel.text = "\(weatherDataToDisplay.temperature)°"
            self.minTemperature.text = "\(weatherDataToDisplay.temperatureMin) °F"
            self.maxTemperature.text = "\(weatherDataToDisplay.temperatureMax) °F"
            self.windSpeed.text = "\(weatherDataToDisplay.windSpeed) mph"
            
        }
        
        if (settingsConfiguration?.unit == UnitSystem.Metric.value){
            self.temperatureLabel.text = "\(weatherDataToDisplay.temperature)°C"
            self.minTemperature.text = "\(weatherDataToDisplay.temperatureMin) °C"
            self.maxTemperature.text = "\(weatherDataToDisplay.temperatureMax) °C"
            self.windSpeed.text = "\(weatherDataToDisplay.windSpeed) kmh"
        }
        
        
        humidityPercent.isHidden = (settingsConfiguration?.humidityIsHidden)!
        windSpeed.isHidden = (settingsConfiguration?.windIsHidden)!
        pressureIndicator.isHidden = (settingsConfiguration?.pressureIsHidden)!
        rainImageView.isHidden = (settingsConfiguration?.humidityIsHidden)!
        windImageView.isHidden = (settingsConfiguration?.windIsHidden)!
        pressureImageView.isHidden = (settingsConfiguration?.pressureIsHidden)!
        
        
        self.pressureIndicator.text = "\(weatherDataToDisplay.pressure) hpa"
        self.humidityPercent.text = "\(weatherDataToDisplay.humidity)%"
        self.summaryLabel.text = weatherDataToDisplay.summary
        self.bodyImageView.image = weatherDataToDisplay.bodyImage
        self.headerImageView.image = weatherDataToDisplay.headerImage
        self.cityLabel.text = weatherDataToDisplay.cityName
        self.view.backgroundColor = weatherDataToDisplay.backgroundColor
    }
    
    func initializeDataObservable(){
        let dataObserver = homeViewModel.dataIsReady
        dataObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] event in
                if event {
                    self.getWeatherDataToDisplay()
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    func initializeErrorObservable() {
        let errorObserver = homeViewModel.errorOccured
        errorObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {  [unowned self] (event) in
                if event {
                    ErrorController.alert(viewToPresent: self, title: "Greška!", message: "Ups, došlo je do pogreške")
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidesWhenStopped = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    func initializeLoaderObservable() {
        let loadingObserver = homeViewModel.loaderControll
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

