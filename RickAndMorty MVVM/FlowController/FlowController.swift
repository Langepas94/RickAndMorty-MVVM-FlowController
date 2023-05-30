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
    
    let mainView = MainTableWithHeroesViewController()
    var detailView: DetailInfoViewControllerProtocol?
    var navigationController: UINavigationController
    let viewModel = HeroOnMainTableViewModel()
    var detailViewModel: DetailHeroViewModelProtocol?
    
    func goToMainScreen() {
        
        viewModel.flowController = self
        mainView.viewModel = viewModel
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(mainView, animated: false)
    }
    
    func goToDetailScreen() {
        
        detailView = DetailInfoViewController()
        detailViewModel = DetailHeroViewModel()
        
        let backButton = UIBarButtonItem(title: self.navigationController.title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        self.navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        
        detailView?.viewModel = detailViewModel!
        
        viewModel.passData = {  model in
            self.detailViewModel?.model = .init(data: model as! HeroModelOnTable)
            
            self.navigationController.pushViewController(self.detailView as! UIViewController, animated: true)
        }
    }
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        goToMainScreen()
        
    }
    
}
