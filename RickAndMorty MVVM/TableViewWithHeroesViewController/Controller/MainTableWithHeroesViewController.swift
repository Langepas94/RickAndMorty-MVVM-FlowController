//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit
import Combine

class MainTableWithHeroesViewController: UIViewController  {
    
    // MARK: - Public properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    public var viewModel: HeroOnMainTableViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
  
    // MARK: - Private properties
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(MainTableHeroesCell.self, forCellReuseIdentifier: MainTableHeroesCell.id)
        table.frame = UIScreen.main.bounds
        table.separatorStyle = .none
        return table
    }()
    
    private let errorView: SearchEmptyView = {
        let errorView = SearchEmptyView()
        errorView.isHidden = true
        return errorView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        setupUI()
        navigationItem.searchController = searchController
    }
    
    // MARK: - Private methods
    
    private func bind(viewModel: HeroOnMainTableViewModel) {
        
        viewModel.$state.removeDuplicates()
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] state in
                        self?.render(state: state)
                    }.store(in: &cancellables)
        viewModel.send(event: .onAppear)
    }
    
    private func render(state: HeroOnMainTableViewModel.State) {
        switch state {
        case .idle:
            break
        case .loading:
            self.table.reloadData()
        case .loaded:
            self.table.reloadData()
        case .error:
            errorView.isHidden = false
            self.table.reloadData()
        case .isFiltered:
            errorView.isHidden = true
            table.reloadData()
        }
    }
}

// MARK: - Setup ui

extension MainTableWithHeroesViewController {
    
    func setupUI() {
        searchController.searchBar.delegate = self
        view.addSubview(table)
        view.addSubview(errorView)
        errorView.frame = CGRect(x: 0, y: view.center.y - 200, width: UIScreen.main.bounds.width, height: 200)
        title = "Characters"
    }
}

// MARK: - Table settings

extension MainTableWithHeroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getModel().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MainTableHeroesCell.id, for: indexPath) as! MainTableHeroesCell
       let modelForCell =  viewModel?.getModel()[indexPath.row]
        cell.configureCell(with: modelForCell)
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        if offsetY > height - scrollView.frame.height {
            self.viewModel?.send(event: .onPageScroll)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.send(event: .onDetailScreen(indexPath.item))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - Searchbar settings

extension MainTableWithHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = viewModel else { return }
        self.viewModel?.send(event: .onFiltered(searchText))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.send(event: .onDefaultState)
    }

}
