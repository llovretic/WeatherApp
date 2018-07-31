//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(named: "square_checkmark_uncheck") as UIImage?
        imageView.image = icon
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textColor = .white
        return label
    }()
    
    var cityLetterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.addSubview(cityImageView)
        self.contentView.addSubview(cityLabel)
        self.contentView.addSubview(cityLetterLabel)
        
        
        cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cityImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cityImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        cityLabel.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 8).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        cityImageView.addSubview(cityLetterLabel)
        cityLetterLabel.centerXAnchor.constraint(equalTo: cityImageView.centerXAnchor).isActive = true
        cityLetterLabel.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
