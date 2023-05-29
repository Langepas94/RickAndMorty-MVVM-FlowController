//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit

class MainTableWithHeroesViewController: UIViewController  {
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: HeroOnMainTableViewModelProtocol? = HeroOnMainTableViewModel()
    
    var table: UITableView = {
        let table = UITableView()
        table.register(MainTableHeroesCell.self, forCellReuseIdentifier: MainTableHeroesCell.id)
        table.frame = UIScreen.main.bounds
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationItem.searchController = searchController

        bindViewModel()
        
    }

    func bindViewModel() {
        self.viewModel?.bindClosure = { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            }
        }
    }
    
    func loadNextPage() {
        viewModel?.nextPage()
        
        if !(viewModel?.pagesIsCancel ?? false) {
            table.reloadData()
        }
    }
}

extension MainTableWithHeroesViewController {
    func setupUI() {
        
        table.dataSource = self
        table.delegate = self
        searchController.searchBar.delegate = self
        view.addSubview(table)
        table.separatorStyle = .none
        title = "Characters"
    }
}

extension MainTableWithHeroesViewController: MainTableWithHeroesViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel?.model?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MainTableHeroesCell.id, for: indexPath) as! MainTableHeroesCell

        let model = self.viewModel?.model?[indexPath.row]
        cell.configureCell(with: model)
        cell.selectionStyle = .none
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        
        if offsetY > height - scrollView.frame.height {
            loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToDetailScreen(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension MainTableWithHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
