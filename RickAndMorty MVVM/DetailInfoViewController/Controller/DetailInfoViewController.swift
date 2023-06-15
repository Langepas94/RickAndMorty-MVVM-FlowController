//
//  DetailInfoViewController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import Foundation
import UIKit
import Combine

class DetailInfoViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    private lazy var species: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    private lazy var type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    private lazy var gender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    private lazy var origin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    private lazy var location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    private lazy var heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mainStackViewWithIncludedStacks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var heroDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    private lazy var staticStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public properties
    
    var viewModel: DetailHeroViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
 
    // MARK: - Private methods
    
    private func bind(viewModel: DetailHeroViewModel) {
        viewModel.$state.removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state: state)
            }.store(in: &cancellables)
        viewModel.send(event: .onAppear)
    }
    
    private func render(state: DetailHeroViewModel.State) {
        switch state {
        case .idle:
            break
        case .loadScreen:
            configure(from: (viewModel?.model)!)
        }
    }
    
    private func configure(from model: DetailHeroModel) {
        self.heroName.text = model.name
        self.heroImage.kf.setImage(with: URL(string: model.image ?? ""))
        self.status.text = model.status.lowercased()
        self.species.text = model.species.lowercased()
        self.gender.text = model.gender.lowercased()
        self.origin.text = model.origin.name?.lowercased()
        self.location.text = model.location.name?.lowercased()
        self.title = self.heroName.text
    
        if model.type == "" {
            self.type.text = "unknown"
        } else {
            self.type.text = model.type.lowercased()
        }
    }
    
}

// MARK: - Setup UI

extension DetailInfoViewController {
    
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
