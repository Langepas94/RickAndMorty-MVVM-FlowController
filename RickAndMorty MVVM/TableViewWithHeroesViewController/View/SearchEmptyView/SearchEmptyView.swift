//
//  SearchEmptyView.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation
import UIKit

final class SearchEmptyView: UIView {
    
   // MARK: - Private properties
    
   private lazy var titleError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Результаты не найдены"
        label.textColor = .black
        return label
    }()
    private lazy var subTitleError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Попробуйте скорректировать запрос"
        label.textColor = .gray
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "loupe")
        return image
    }()
    
    // MARK: - Configure UI
    
   private func configureUI() {
        addSubview(image)
        addSubview(titleError)
        addSubview(subTitleError)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            image.widthAnchor.constraint(equalToConstant: 56),
            image.heightAnchor.constraint(equalToConstant: 56),
            
            titleError.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleError.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            
            subTitleError.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleError.topAnchor.constraint(equalTo: titleError.bottomAnchor,
                                                   constant: 8)
        ])
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
