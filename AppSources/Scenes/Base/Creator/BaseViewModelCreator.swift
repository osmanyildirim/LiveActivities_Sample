//
//  BaseViewModelCreator.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import Foundation

protocol BaseViewModelCreator {
    associatedtype ViewModel

    static func create() -> ViewModel
}
