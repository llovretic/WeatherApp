//
//  SettingsTableViewCell.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 31/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var settingsViewCellDelegate: SettingsViewCellDelegate?

    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    var cityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "square_checkmark_uncheck"), for: .normal)
        button.backgroundColor = .clear
        button.setTitle("X", for: .normal)
        button.setTitleColor(UIColor.lightText, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        self.contentView.addSubview(cityButton)
        cityButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cityButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.contentView.addSubview(cityLabel)
        cityLabel.centerYAnchor.constraint(equalTo: cityButton.centerYAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: cityButton.trailingAnchor, constant: 8).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        cityButton.addTarget(self, action: #selector(deleteButtonTaped), for: .touchUpInside)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonTaped(sender: UIButton){
        settingsViewCellDelegate?.deleteButtonTapped(sender: self)
    }

}
