//
//  MainTableHeroesCell.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import UIKit
import Kingfisher

class MainTableHeroesCell: UITableViewCell {
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
}

extension MainTableHeroesCell: MainTableHeroesCellProtocol {
    
    static var id: String  = "WeatherCellId"
    
    func configureCell(with data: HeroModelOnTableProtocol?) {
        setupUI()
        name.text = data?.name
        image.kf.setImage(with: URL(string: data?.image ?? ""))
    }
    
    func setupUI() {
        
        addSubview(name)
        addSubview(image)
        NSLayoutConstraint.activate([
        
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20)
        
        ])
      
        //        name.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
//        name.center = center
    }
    
    
}
