//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

final class FlowController {
    // MARK: - Private properties
    private var navigationController: UINavigationController
    private var viewModel = HeroOnMainTableViewModel(service: NetworkManagerImpl())
    private var detailViewModel = DetailHeroViewModel()
    
    // MARK: - Public methods
    
    func goToDetailScreen() {
        let detailView = DetailInfoViewController()
        detailView.viewModel = detailViewModel
        let backButton = UIBarButtonItem(title: self.navigationController.title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        self.navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        viewModel.passData = {  model in
            self.detailViewModel.model = .init(data: model)

            self.navigationController.pushViewController(detailView, animated: true)
        }
    }
    
    // MARK: - Private methods
    
    private func goToMainScreen() {
        let mainView = MainTableWithHeroesViewController()
        mainView.viewModel  = viewModel
        viewModel.flowController = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(mainView, animated: false)
    }
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        goToMainScreen()
    }
}
