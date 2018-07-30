//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 30/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let disposeBag = DisposeBag()
    var settingsViewModel: SettingsViewModel!
    var alert = UIAlertController()
    let cellIdentifier = "WeatherViewCell"
    
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_uncheck"), for: .normal)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var citiesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect )
        //        view.backgroundView = blurEffectView
        view.separatorColor = .clear
        view.separatorStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.text = "Location"
        label.textColor = UIColor.white
        return label
    }()
    
    var unitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.text = "Units"
        label.textColor = UIColor.white
        return label
    }()
    
    var metricButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "square_checkmark_uncheck"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "square_checkmark_check"), for: .selected)
        //        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var metricLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.text = "Metric"
        label.textColor = UIColor.white
        return label
    }()
    
    var imperialButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "square_checkmark_uncheck"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "square_checkmark_check"), for: .selected)
        button.setTitleColor(.clear, for: .normal)
        //        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    var imperialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.text = "Imperial"
        label.textColor = UIColor.white
        return label
    }()
    
    var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        label.text = "Conditions"
        label.textColor = UIColor.white
        return label
    }()
    
    
    var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "humidity_icon")
        return imageView
    }()
    
    var humidityButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_uncheck"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_check"), for: .selected)
        button.setTitleColor(.clear, for: .normal)
        //        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "wind_icon")
        return imageView
    }()
    
    var windButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_uncheck"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_check"), for: .selected)
        button.setTitleColor(.clear, for: .normal)
        //        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    var pressureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pressure_icon")
        return imageView
    }()
    
    var pressureButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_uncheck"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "checkmark_check"), for: .selected)
        button.setTitleColor(.clear, for: .normal)
        //        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var stackViewRainWindPressureImages: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var stackViewRainWindPressureButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        citiesTableView.register(CityTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        settingsViewModel.getStoredCities().disposed(by: disposeBag)
        setupView()
        initializeRealmObservable()
        initializeError()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataFromRealm()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParentViewController {
            settingsViewModel.settingsCoordinatorDelegate?.viewHasFinished()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.cities.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CityTableViewCell else {
            return UITableViewCell()
        }
        let cityData = settingsViewModel.cities[indexPath.row]
        cell.cityLabel.text = cityData.cityname
        cell.cityLetterLabel.text = String(describing: cityData.cityname!.first!)
        return  cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        searchViewModel.citySelected(selectedCity: indexPath.row)
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.settingsViewModel.deleteSelectedCity(selectedCity: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func setupView(){
        view.addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(citiesTableView)
        citiesTableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10).isActive = true
        citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        citiesTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(unitsLabel)
        unitsLabel.topAnchor.constraint(equalTo: citiesTableView.bottomAnchor, constant: 10).isActive = true
        unitsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        unitsLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(metricButton)
        metricButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        metricButton.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: 10).isActive = true
        metricButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        metricButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(metricLabel)
        metricLabel.leadingAnchor.constraint(equalTo: metricButton.trailingAnchor, constant: 8).isActive = true
        metricLabel.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: 10).isActive = true
        metricLabel.centerYAnchor.constraint(equalTo: metricButton.centerYAnchor).isActive = true
        
        view.addSubview(imperialButton)
        imperialButton.topAnchor.constraint(equalTo: metricButton.bottomAnchor, constant: 4).isActive = true
        imperialButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imperialButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imperialButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(imperialLabel)
        imperialLabel.leadingAnchor.constraint(equalTo: imperialButton.trailingAnchor, constant: 8).isActive = true
        imperialLabel.topAnchor.constraint(equalTo: metricButton.bottomAnchor).isActive = true
        imperialLabel.centerYAnchor.constraint(equalTo: imperialButton.centerYAnchor).isActive = true
        
        view.addSubview(conditionLabel)
        conditionLabel.topAnchor.constraint(equalTo: imperialButton.bottomAnchor, constant: 10).isActive = true
        conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        conditionLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(stackViewRainWindPressureImages)
        stackViewRainWindPressureImages.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewRainWindPressureImages.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewRainWindPressureImages.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 10).isActive = true
        stackViewRainWindPressureImages.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackViewRainWindPressureImages.addArrangedSubview(humidityImageView)
        stackViewRainWindPressureImages.addArrangedSubview(windImageView)
        stackViewRainWindPressureImages.addArrangedSubview(pressureImageView)
        
        view.addSubview(stackViewRainWindPressureButtons)
        stackViewRainWindPressureButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewRainWindPressureButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackViewRainWindPressureButtons.topAnchor.constraint(equalTo: stackViewRainWindPressureImages.bottomAnchor, constant: 4).isActive = true
        stackViewRainWindPressureImages.addArrangedSubview(humidityButon)
        stackViewRainWindPressureImages.addArrangedSubview(windButon)
        stackViewRainWindPressureImages.addArrangedSubview(pressureButon)
        
    }
    
    @objc func doneButtonPressed() {
        self.settingsViewModel.dissmissTheView()
    }
    
    func getDataFromRealm() {
        settingsViewModel.realmTrigger.onNext(true)
    }

    func initializeRealmObservable() {
        let observer = settingsViewModel.dataIsReady
        observer
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                if event {
                    self.setupView()
                    self.citiesTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func initializeError() {
        let errorObserver = self.settingsViewModel.errorOccurd
        errorObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (event) in
                if event {
                     ErrorController.alert(viewToPresent: self, title: "Greška!", message: "Ups, došlo je do pogreške")
                } else {
                }
            })
            .disposed(by: disposeBag)
    }
}
