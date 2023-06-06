//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit
import Combine

final class FlowController: FlowControllerProtocol {
    
    var navigationController: UINavigationController
    var viewModel: HeroOnMainTableViewModelProtocol  = HeroOnMainTableViewModel()
    var detailViewModel: DetailHeroViewModelProtocol = DetailHeroViewModel()
    var cancellables: Set<AnyCancellable> = []
    
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
        
        viewModel.detailScreenPublisher
            .sink { model in
                print(model)
                self.detailViewModel.model = .init(data: model as! HeroModelOnTable)
            }
            .store(in: &cancellables)
        self.navigationController.pushViewController(detailView, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        goToMainScreen()
        
    }
    
}
