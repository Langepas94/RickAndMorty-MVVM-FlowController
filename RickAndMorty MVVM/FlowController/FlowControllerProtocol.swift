//
//  FlowControllerProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import Foundation
import UIKit

protocol FlowControllerProtocol {
    var navigationController: UINavigationController { get set }
    func goToMainScreen()
}
