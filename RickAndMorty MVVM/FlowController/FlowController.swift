//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

final class FlowController: UINavigationController {
   
    // MARK: - Private properties
    
    private var viewModel = HeroOnMainTableViewModel(service: NetworkManagerImpl())
    
    // MARK: - Public methods
    
    func goToDetailScreen(_ model: DetailHeroViewModel? = nil) {
        let detailView = DetailInfoViewController()
        let detailViewModel = DetailHeroViewModel()
        detailView.viewModel = detailViewModel
        let backButton = UIBarButtonItem(title: self.title, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        self.navigationBar.topItem?.backBarButtonItem = backButton
        
        viewModel.passData = {  model in
            detailViewModel.model = .init(data: model)
        }
        self.pushViewController(detailView, animated: true)
    }
    
    // MARK: - Private methods
    
    private func goToMainScreen() {
        let mainView = MainTableWithHeroesViewController()
        mainView.viewModel  = viewModel
        viewModel.flowController = self
        self.navigationBar.prefersLargeTitles = true
        self.pushViewController(mainView, animated: false)
    }
    
    // MARK: - Init
    init(viewModel: HeroOnMainTableViewModel = HeroOnMainTableViewModel(service: NetworkManagerImpl())) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        goToMainScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
