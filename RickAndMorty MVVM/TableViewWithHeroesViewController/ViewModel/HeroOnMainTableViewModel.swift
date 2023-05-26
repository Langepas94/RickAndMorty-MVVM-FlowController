//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

class HeroOnMainTableViewModel: HeroOnMainTableViewModelProtocol {
    
    var maximumPage: Int?
    
    var pagesIsCancel: Bool = false
    
    var currentPage: Int = 1
    
    let network = NetworkManager()
    
    var model: [HeroModelOnTableProtocol]? = [HeroModelOnTableProtocol]()
    
    var bindClosure: ((Bool) -> Void)?
     
    var passData: ((HeroModelOnTableProtocol) -> Void)?
    
    weak var flowController: FlowController?
    
    private func fetchData() {
        
        self.network.getAllCharacters(page: currentPage) { [weak self] result in
            
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self?.maximumPage = data?.info?.pages
                   
                    self?.model?.append(contentsOf: heroModels ?? [])
                    self?.handleResponse(success: true)
                }
              
            case .failure(let error):
                self?.handleResponse(success: false)
                print(error)
            }
        }
    }
    
    func nextPage() {
        if currentPage < maximumPage ?? 0 {
            currentPage += 1
            
                fetchData()
            
        } else if currentPage == maximumPage {
            pagesIsCancel = true
        }
    }
    
    func handleResponse(success: Bool ) {
        if let bindClosure = self.bindClosure {
            bindClosure(success)
        }
    }
    
    func goToDetailScreen(index: Int) {

        flowController?.goToDetailScreen()
        guard let returnedModel = model?[index] else { return }
        passData?(returnedModel)
        
    }
    
    
    init () {
        fetchData()
    }
    
}
