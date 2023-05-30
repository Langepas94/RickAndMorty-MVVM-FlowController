//
//  DetailInfoViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import Foundation
import UIKit

class DetailInfoViewController: UIViewController {
    
    var heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    var species: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    var type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    var gender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    var origin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    var location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    var heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var mainStackViewWithIncludedStacks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    var heroDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    var staticStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    var viewModel: DetailHeroViewModelProtocol? = DetailHeroViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        title = heroName.text
    }
    
}

extension DetailInfoViewController: DetailInfoViewControllerProtocol {}

extension DetailInfoViewController {
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(heroImage)
        view.addSubview(mainStackViewWithIncludedStacks)
        view.addSubview(staticStackView)
        view.addSubview(heroDescriptionStackView)
        
        heroDescriptionStackView.addArrangedSubview(status)
        heroDescriptionStackView.addArrangedSubview(species)
        heroDescriptionStackView.addArrangedSubview(type)
        heroDescriptionStackView.addArrangedSubview(gender)
        heroDescriptionStackView.addArrangedSubview(origin)
        heroDescriptionStackView.addArrangedSubview(location)
        
        mainStackViewWithIncludedStacks.addArrangedSubview(staticStackView)
        mainStackViewWithIncludedStacks.addArrangedSubview(heroDescriptionStackView)
        
        viewModel?.configureData(self)
        NSLayoutConstraint.activate([
            
            heroImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            heroImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            heroImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mainStackViewWithIncludedStacks.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 24),
            mainStackViewWithIncludedStacks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            mainStackViewWithIncludedStacks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            mainStackViewWithIncludedStacks.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
        
    }
    
    func setupStackView() {
        let typeToScrollLabels = createStackLabels(labels: ["Status: ", "Species: ", "Type: ", "Gender: ", "Origin: ", "Location: "])
        typeToScrollLabels.forEach { uiLabel in
            staticStackView.addArrangedSubview(uiLabel)
        }
    }
}
