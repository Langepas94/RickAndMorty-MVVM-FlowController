//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

protocol MainTableWithHeroesViewControllerProtocol:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: HeroOnMainTableViewModelProtocol? { get set }
    var table: UITableView { get set }
    func bindViewModel()
}

final class FlowController: FlowControllerProtocol {
    // navigation controller
    // в иниты все засунуть
    let mainView = MainTableWithHeroesViewController()
    let detailView = DetailInfoViewController()
    var navigationController: UINavigationController
    let viewModel = HeroOnMainTableViewModel()
    let detailViewModel = DetailHeroViewModel()
    
    func loadingMainScreen() {
        goToMainScreen()
    }
    
    func goToMainScreen() {
        
        viewModel.flowController = self
        mainView.viewModel = viewModel
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(mainView, animated: false)

    }
    
    func goToDetailScreen() {
        
        detailView.viewModel = detailViewModel
        viewModel.passData = {  model in
            self.detailViewModel.model = .init(data: model as! HeroModelOnTable)
            self.navigationController.present(self.detailView, animated: true)

        }
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
}
