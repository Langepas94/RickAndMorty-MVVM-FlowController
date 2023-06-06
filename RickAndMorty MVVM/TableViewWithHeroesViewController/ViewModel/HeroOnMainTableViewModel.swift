//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import Combine

final class HeroOnMainTableViewModel: HeroOnMainTableViewModelProtocol {
    
    var bindClosureFiltered: ((Bool) -> Void)?
    
    var maximumPage: Int?
    
    var pagesIsCancel: Bool = false
    
    var currentPage: Int = 1
    var filterCurrentPage: Int = 1
    
    let network = NetworkManager()
    
    var model: [HeroModelOnTableProtocol]? = [HeroModelOnTableProtocol]()
    
    var filteredModel: [HeroModelOnTableProtocol]? = [HeroModelOnTableProtocol]()
    
    var passData: ((HeroModelOnTableProtocol) -> Void)?
    
    weak var flowController: FlowController?
    
    var isFiltered: Bool = false
    
    var cancellables: Set<AnyCancellable> = []
    
    var updatePublisher = PassthroughSubject<Void, Never>()
    // MARK: - Fetch Data
    private func fetchData() {
        self.network.loadAllHeroes(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.updatePublisher.send()
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                let charData = data.results
                let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                self.maximumPage = data.info?.pages
                self.model?.append(contentsOf: heroModels ?? [])
            }
            .store(in: &cancellables)
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
        self.network.loadFilteredHeroes(page: filterCurrentPage, phrase: phrase)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    self.updatePublisher.send()
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.zeroFiltered()
                let charData = data.results
                let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                self.maximumPage = data.info?.pages
                self.filteredModel?.append(contentsOf: heroModels ?? [])
            }
            .store(in: &cancellables)
    }
    
    func zeroFiltered() {
        self.filteredModel?.removeAll()
    }
    
    init () {
        fetchData()
    }
    
}
