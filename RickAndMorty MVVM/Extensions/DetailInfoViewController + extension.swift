//
//  DetailInfoViewController + extension.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation
import UIKit

extension DetailInfoViewController {
    func createStackLabels(labels: [String]) -> [UILabel] {
        var returnedArray: [UILabel] = []
        for string in labels {
            let label = UILabel()
            label.text = string
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 22, weight: .medium)

            label.textColor = .systemGray
            label.textAlignment = .left
            label.adjustsFontSizeToFitWidth = true

            returnedArray.append(label)
        }
        return returnedArray
    }
}
