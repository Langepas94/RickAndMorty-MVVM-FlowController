//
//  MainTableHeroesCell.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import UIKit
import Kingfisher

final class MainTableHeroesCell: UITableViewCell {
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    var smallDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = image.frame.height / 2
    }
}

extension MainTableHeroesCell {
    
    static var id: String  = "WeatherCellId"
    
    func configureCell(with data: HeroModelOnTable?) {
        setupUI()
        name.text = data?.name
        image.kf.setImage(with: URL(string: data?.image ?? ""))
        smallDescription.text = data?.description
    }
    
    func setupUI() {
        
        addSubview(name)
        addSubview(image)
        addSubview(smallDescription)
        NSLayoutConstraint.activate([
        
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            smallDescription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            smallDescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 12),
        ])
    }
    
    
}
