//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import Combine

final class HeroOnMainTableViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error
        case isFiltered([HeroModelOnTable])
    }
    
    enum Event {
        case onAppear
        case onFiltered(String?)
        case onPageScroll
        case onDefaultState
        case onDetailScreen(Int)
    }
    
    var passData: ((HeroModelOnTable) -> Void)?
    weak var flowController: FlowController?
    
    // MARK: - Private properties
    
    private var maximumPage: Int?
    private var pagesIsCancel: Bool = false
    private var currentPage: Int = 1
    private var filterCurrentPage: Int = 1
    private var model: [HeroModelOnTable]? = [HeroModelOnTable]()
    private var filteredModel: [HeroModelOnTable]? = [HeroModelOnTable]()
    private var bindClosure: ((Bool) -> Void)?
    private var isFiltered: Bool = false
    private let service: HeroNetworkService
    private var bindClosureFiltered: ((Bool) -> Void)?
    private var searchText = ""
    
    @Published private(set) var state: State = .idle
    
    // MARK: - Init
    
    init(service: HeroNetworkService) {
        self.service = service
    }
    
    // MARK: - Public methods
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            fetchData()
        case .onFiltered(let text):
            zeroFiltered()
            guard let text = text else { return }
            self.searchText = text
            filterCurrentPage = 1
            if text.count >= 1 {
                getFiltered(phrase: text)
                isFiltered = true
            } else {
                isFiltered = false
                self.state = .loaded
            }
        case .onPageScroll:
            nextPage()
        case .onDefaultState:
            filterCurrentPage = 1
            currentPage = 1
            fetchData()
            isFiltered = false
            self.state = .loaded
            
        case .onDetailScreen(let index):
            goToDetailScreen(index: index)
        }
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        self.service.getAllCharacters(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self.maximumPage = data?.info?.pages
                    self.model?.append(contentsOf: heroModels ?? [])
                    self.state = .loaded
                    self.handleResponse(success: true)
            case .failure(_):
                self.handleResponse(success: false)
                self.state = .error
            }
        }
    }
    
    // MARK: - Fetch Filtered Data
    
    private func getFiltered(phrase: String) {
        self.service.getFilteredCharacters(page: filterCurrentPage, phrase: phrase) { [weak self]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                
                    let charData = data?.results
                    let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self.maximumPage = data?.info?.pages
                    self.filteredModel?.append(contentsOf: heroModels ?? [])
                    if self.filteredModel != [] {
                        self.state = .isFiltered(heroModels ?? [])
                    } else {
                        self.state = .error
                    }
                    self.handleResponse(success: true)
                
            case .failure(_): break
            }
        }
    }
    
    // MARK: - Pagination settings
    
    private func nextPage() {
        if isFiltered == false {
            if currentPage < maximumPage ?? 0 {
                currentPage += 1
                fetchData()
                self.state = .loading
                
            } else if currentPage == maximumPage {
                pagesIsCancel = true
            }
            
        } else {
            if filterCurrentPage < maximumPage ?? 0 {
                filterCurrentPage += 1
                getFiltered(phrase: searchText)
            } else if filterCurrentPage == maximumPage {
                pagesIsCancel = true
            }
        }
    }
    
    private func handleResponse(success: Bool ) {
        if let bindClosure = self.bindClosure {
            bindClosure(success)
        }
        if let bindClosure = self.bindClosureFiltered {
            bindClosure(success)
        }
    }
    
    // MARK: - on Detail screen
    
    private func goToDetailScreen(index: Int) {
        flowController?.goToDetailScreen()
        if isFiltered {
            guard let returnedModel = filteredModel?[index] else { return }
            passData?(returnedModel)
        } else {
            guard let returnedModel = model?[index] else { return }
            passData?(returnedModel)
        }
        
    }
    
    private func zeroFiltered() {
        self.filteredModel?.removeAll()
    }
    
    func getModel() -> [HeroModelOnTable] {
        if isFiltered == false {
            return self.model ?? [HeroModelOnTable]()
        } else {
            return self.filteredModel ?? [HeroModelOnTable]()
        }
    }
}
