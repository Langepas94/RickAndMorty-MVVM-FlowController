//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

final class HeroOnMainTableViewModel: HeroOnMainTableViewModelProtocol {
    
    var bindClosureFiltered: ((Bool) -> Void)?
    
    var maximumPage: Int?
    
    var pagesIsCancel: Bool = false
    
    var currentPage: Int = 1
    var filterCurrentPage: Int = 1
    
    let network = NetworkManager()
    
    var model: [HeroModelOnTableProtocol]? = [HeroModelOnTableProtocol]()
    
    var filteredModel: [HeroModelOnTableProtocol]? = [HeroModelOnTableProtocol]()
    
    var bindClosure: ((Bool) -> Void)?
     
    var passData: ((HeroModelOnTableProtocol) -> Void)?
    
    weak var flowController: FlowController?
    
    var isFiltered: Bool = false
    
    // MARK: - Fetch data
    private func fetchData() {
        
        self.network.getAllCharacters(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self.maximumPage = data?.info?.pages
                   
                    self.model?.append(contentsOf: heroModels ?? [])
                    
                    self.handleResponse(success: true)
                }
              
            case .failure(let error):
                self.handleResponse(success: false)
                print(error)
            }
        }
    }
    
    func nextPage() {
        if isFiltered == false {
            if currentPage < maximumPage ?? 0 {
                currentPage += 1
                
                    fetchData()
                
            } else if currentPage == maximumPage {
                pagesIsCancel = true
            }
        } else {
            if filterCurrentPage < maximumPage ?? 0 {
                filterCurrentPage += 1
                
                    fetchData()
                
            } else if filterCurrentPage == maximumPage {
                pagesIsCancel = true
            }
        }
       
    }
    
    func handleResponse(success: Bool ) {
        if let bindClosure = self.bindClosure {
            bindClosure(success)
        }
        if let bindClosure = self.bindClosureFiltered {
            bindClosure(success)
        }
    }
    
    func goToDetailScreen(index: Int) {

        flowController?.goToDetailScreen()
        if isFiltered {
            guard let returnedModel = filteredModel?[index] else { return }
            passData?(returnedModel)
        } else {
            guard let returnedModel = model?[index] else { return }
            passData?(returnedModel)
        }
    }
    // MARK: - Fetch Filtered Data
    func getFiltered(phrase: String) {
        self.network.getFilteredCharacters(page: filterCurrentPage, phrase: phrase) { [weak self]
            result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self.maximumPage = data?.info?.pages
                    
                    self.filteredModel?.append(contentsOf: heroModels ?? [])

                    self.handleResponse(success: true)
                }
            case .failure(let error): break
            }
        }
    }
    
    func zeroFiltered() {
        self.filteredModel?.removeAll()
    }
    
    init () {
        
        fetchData()
        
    }
    
}
