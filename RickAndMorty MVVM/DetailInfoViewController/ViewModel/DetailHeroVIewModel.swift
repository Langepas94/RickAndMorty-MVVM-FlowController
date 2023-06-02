//
//  DetailHeroVIewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation

final class DetailHeroViewModel: DetailHeroViewModelProtocol {
    
    var model: DetailHeroModel?
    
    func configureData(_ controller: DetailInfoViewControllerProtocol) {
        controller.heroName.text = model?.name
        controller.heroImage.kf.setImage(with: URL(string: model?.image ?? ""))
        controller.status.text = model?.status.lowercased()
        controller.species.text = model?.species.lowercased()
        controller.gender.text = model?.gender.lowercased()
        controller.origin.text = model?.origin.name?.lowercased()
        controller.location.text = model?.location.name?.lowercased()
        
        if model?.type == "" {
            controller.type.text = "unknown"
            
        } else {
            controller.type.text = model?.type.lowercased()
        }
    }
    

}
