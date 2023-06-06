//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit
import Combine

class MainTableWithHeroesViewController: UIViewController  {
    
    var table: UITableView = {
        let table = UITableView()
        table.register(MainTableHeroesCell.self, forCellReuseIdentifier: MainTableHeroesCell.id)
        table.frame = UIScreen.main.bounds
        table.separatorStyle = .none
        return table
    }()
    
    let errorView: SearchEmptyView = {
        let errorView = SearchEmptyView()
        errorView.isHidden = true
        return errorView
    }()
    
    private var searchPublisher = PassthroughSubject<String, Never>()
    
    var cancellables: Set<AnyCancellable> = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: HeroOnMainTableViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        setupUI()
        
        navigationItem.searchController = searchController
        
        publishersActions()
    }
    
    init(viewModel: HeroOnMainTableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Publishers Setup
    func publishersActions() {
        viewModel.updatePublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if self.viewModel.filteredModel?.count == 0 {
                        
                        self.errorView.isHidden = false
                    } else {
                        self.errorView.isHidden = true
                    }
                    self.table.reloadData()
                }
            }
            .store(in: &cancellables)
        
        searchPublisher
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (searchString: String) in
                guard let self = self else { return }
                if searchString.count > 0 {
                    self.viewModel.isFiltered = true
                } else {
                    self.viewModel.isFiltered = false
                }
                self.viewModel.getFiltered(phrase: searchString.lowercased())
                self.table.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        viewModel.nextPage()
        
        if !(viewModel.pagesIsCancel ) {
            table.reloadData()
        }
    }
}

extension MainTableWithHeroesViewController {
    // MARK: - Setup ui
    func setupUI() {
        
        searchController.searchBar.delegate = self
        view.addSubview(table)
        view.addSubview(errorView)
        errorView.frame = CGRect(x: 0, y: view.center.y - 200, width: UIScreen.main.bounds.width, height: 200)
        title = "Characters"
    }
}

// MARK: - Table setup
extension MainTableWithHeroesViewController: MainTableWithHeroesViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.isFiltered == false {
            errorView.isHidden = true
            return viewModel.model?.count ?? 0
        } else {
            return viewModel.filteredModel?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MainTableHeroesCell.id, for: indexPath) as! MainTableHeroesCell
        
        if viewModel.isFiltered == false {
            let model = self.viewModel.model?[indexPath.row]
            cell.configureCell(with: model)
        } else if viewModel.isFiltered == true {
            let model = self.viewModel.filteredModel?[indexPath.row]
            cell.configureCell(with: model)
            
        }
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        if offsetY > height - scrollView.frame.height {
            loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetailScreen(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - UIsearchBar settings
extension MainTableWithHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchController.searchBar.text else { return }
        searchPublisher.send(text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltered = false
        self.table.reloadData()
    }
}
