//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import Combine

final class HeroOnMainTableViewModel: ObservableObject {
    
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
    }
    
    var bindClosureFiltered: ((Bool) -> Void)?
    
    private var maximumPage: Int?
    private var pagesIsCancel: Bool = false
    private var currentPage: Int = 1
    private var filterCurrentPage: Int = 1
    private var model: [HeroModelOnTable]? = [HeroModelOnTable]()
    private var filteredModel: [HeroModelOnTable]? = [HeroModelOnTable]()
    private var bindClosure: ((Bool) -> Void)?
    var passData: ((HeroModelOnTable) -> Void)?
    
    weak var flowController: FlowController?
    
    private var isFiltered: Bool = false
    
    // MARK: - Private properties
    
    @Published private(set) var state: State = .idle
    
    private let service: NetworkManager
    
    // MARK: - Init
    
    init(service: NetworkManager) {
        self.service = service
    }
    
    private var searchText = ""
    
    // MARK: - Public methods
    
    func send(event: Event) {
        switch event {
            
        case .onAppear:
            fetchData()
            
//            self.state = .loading
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
        }
    }

    // MARK: - Fetch data
    
    private func fetchData() {
        
        self.service.getAllCharacters(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    let charData = data?.results
                   let heroModels = charData?.map{HeroModelOnTable(data: $0)}
                    self.maximumPage = data?.info?.pages
                   
                    self.model?.append(contentsOf: heroModels ?? [])
                    
                    self.handleResponse(success: true)
                    self.state = .loaded
                }
              
            case .failure(let error):
                self.handleResponse(success: false)
                self.state = .error
            }
        }
    }
    
    // MARK: - Fetch Filtered Data
    
    func getFiltered(phrase: String) {
        self.service.getFilteredCharacters(page: filterCurrentPage, phrase: phrase) { [weak self]
            result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
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
                   
                    
                }
            case .failure(let error): break
            }
        }
    }
    
    // MARK: - Pagination settings
    
    func nextPage() {
        
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
    
    func handleResponse(success: Bool ) {
        if let bindClosure = self.bindClosure {
            bindClosure(success)
        }
        if let bindClosure = self.bindClosureFiltered {
            bindClosure(success)
        }
    }
    
    // MARK: - on Detail screen 
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
