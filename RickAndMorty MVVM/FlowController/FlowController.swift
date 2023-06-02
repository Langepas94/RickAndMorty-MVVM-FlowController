//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

final class FlowController: FlowControllerProtocol {
    
    var navigationController: UINavigationController
    var viewModel: HeroOnMainTableViewModelProtocol  = HeroOnMainTableViewModel()
    var detailViewModel: DetailHeroViewModelProtocol = DetailHeroViewModel()
    
    func goToMainScreen() {
        let mainView = MainTableWithHeroesViewController(viewModel: viewModel)
        viewModel.flowController = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(mainView, animated: false)
    }
    
    func goToDetailScreen() {
        
        let detailView = DetailInfoViewController(viewModel: detailViewModel)
        
        let backButton = UIBarButtonItem(title: self.navigationController.title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        
        self.navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        
        viewModel.passData = {  model in
            self.detailViewModel.model = .init(data: model as! HeroModelOnTable)
            
            self.navigationController.pushViewController(detailView, animated: true)
        }
    }
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        goToMainScreen()
        
    }
    
}
