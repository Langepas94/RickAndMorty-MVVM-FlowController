//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit

class MainTableWithHeroesViewController: UIViewController  {
    
    var viewModel: HeroOnMainTableViewModelProtocol? = HeroOnMainTableViewModel()
    
    var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "proba")
        table.frame = UIScreen.main.bounds
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    func bindViewModel() {
        self.viewModel?.bindClosure = { [weak self] data, success in
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
        view.addSubview(table)
    }
}

extension MainTableWithHeroesViewController: MainTableWithHeroesViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel?.model?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "proba", for: indexPath)
        cell.textLabel?.text = self.viewModel?.model?[indexPath.row].name
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        
        if offsetY > height - scrollView.frame.height {
            loadNextPage()
        }
    }
}

