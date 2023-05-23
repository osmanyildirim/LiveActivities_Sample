//
//  MainViewModelCreator.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation

final class MainViewModelCreator: BaseViewModelCreator {
    typealias ViewModel = MainViewModel

    static func create() -> MainViewModel {
        MainViewModel()
    }
}
