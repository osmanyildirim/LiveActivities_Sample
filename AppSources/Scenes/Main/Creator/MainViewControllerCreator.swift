//
//  MainViewControllerCreator.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit

final class MainViewControllerCreator: BaseViewControllerCreator {
    static func create() -> UIViewController {
        let viewController = MainViewController()
        viewController.viewModel = MainViewModelCreator.create()
        return viewController
    }
}
