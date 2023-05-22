//
//  ViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit

class MainTableWithHeroesViewController: UIViewController  {
    
    var viewModel: HeroOnMainTableViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }
    
    var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "proba")
        return table
    }()
    
    
    var mock = [HeroModelOnTable(name: "Bar"), HeroModelOnTable(name: "Baz"), HeroModelOnTable(name: "Foo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.viewModel = HeroOnMainTableViewModel(model: mock)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel?.model.append(HeroModelOnTable(name: "Bar2"))
        }
    }

    func bindViewModel() {
        viewModel?.setName()
        table.reloadData()
    }
}

extension MainTableWithHeroesViewController {
    func setupUI() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.frame = view.bounds
    }
}

extension MainTableWithHeroesViewController: MainTableWithHeroesViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "proba", for: indexPath)
        cell.textLabel?.text = viewModel?.labels[indexPath.row]
        
        return cell
    }
    

}

