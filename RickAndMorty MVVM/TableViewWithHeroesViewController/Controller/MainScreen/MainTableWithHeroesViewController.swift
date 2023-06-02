//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit

class MainTableWithHeroesViewController: UIViewController  {
    
    let searchController = UISearchController(searchResultsController: nil)

    var viewModel: HeroOnMainTableViewModelProtocol
    
    var table: UITableView = {
        let table = UITableView()
        table.register(MainTableHeroesCell.self, forCellReuseIdentifier: MainTableHeroesCell.id)
        table.frame = UIScreen.main.bounds
        
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        setupUI()
        
        navigationItem.searchController = searchController
        
        bindViewModel()
    }
    
    init(viewModel: HeroOnMainTableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding ViewModel
    func bindViewModel() {
        
        if self.viewModel.isFiltered == false {
            table.reloadData()
            self.viewModel.bindClosure = { [weak self] success in
                guard let self = self else { return }
                if success {
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
        } else if self.viewModel.isFiltered == true {
            self.viewModel.bindClosureFiltered = { [weak self] success in
                guard let self = self else { return }
                if success {
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    func loadNextPage() {
        viewModel.nextPage()
        
        if !(viewModel.pagesIsCancel ?? false) {
            table.reloadData()
        }
    }
}

extension MainTableWithHeroesViewController {
    // MARK: - Setup ui
    func setupUI() {
       
        searchController.searchBar.delegate = self
        view.addSubview(table)
        
        title = "Characters"
    }
}

extension MainTableWithHeroesViewController: MainTableWithHeroesViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.isFiltered == false {
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
        } else {
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

extension MainTableWithHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.zeroFiltered()
        
        if searchText.count > 1 {
            self.viewModel.isFiltered = true
            self.viewModel.getFiltered(phrase: searchText.lowercased())
            
        } else {
            self.viewModel.isFiltered = false
            self.viewModel.getFiltered(phrase: searchText.lowercased())
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.zeroFiltered()
        self.viewModel.isFiltered = false
        bindViewModel()
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.bindViewModel()
    }
}
