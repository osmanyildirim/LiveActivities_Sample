//
//  MainViewModel.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit
import WidgetKit

@available(iOS 16.1, *)
final class MainViewModel {
    private var userDefaults = UserDefaults.standard
    private let activityManager = ActivityManager()

    /// All Pokemons from `source.json`
    private var couriers = [
        Courier(name: "Luis"),
        Courier(name: "Nina"),
        Courier(name: "Rafael")
    ]

    private var luisStatus: Int {
        userDefaults.integer(forKey: "luisStatus")
    }

    private var ninaStatus: Int {
        userDefaults.integer(forKey: "ninaStatus")
    }

    private var rafaelStatus: Int {
        userDefaults.integer(forKey: "rafaelStatus")
    }

    private var luisPizzaCount: Int {
        userDefaults.integer(forKey: "luisPizzaCount")
    }

    private var ninaPizzaCount: Int {
        userDefaults.integer(forKey: "ninaPizzaCount")
    }

    private var rafaelPizzaCount: Int {
        userDefaults.integer(forKey: "rafaelPizzaCount")
    }

    init() {
        couriers[0].updateStatus(luisStatus)
        couriers[1].updateStatus(ninaStatus)
        couriers[2].updateStatus(rafaelStatus)

        couriers[0].updatePizzaCount(luisPizzaCount)
        couriers[1].updatePizzaCount(ninaPizzaCount)
        couriers[2].updatePizzaCount(rafaelPizzaCount)

        if luisStatus != 4 {
            startActivity(courier: couriers[0])
        }
        if ninaStatus != 4 {
            startActivity(courier: couriers[1])
        }
        if rafaelStatus != 4 {
            startActivity(courier: couriers[2])
        }
    }

    func getCourier(_ index: Int) -> Courier? {
        guard index < couriers.count else { return nil }
        return couriers[index]
    }

    func updateStatus(index: Int, status: OrderStatus) {
        guard index < couriers.count else { return }
        couriers[index].status = status

        switch index {
        case 0:
            userDefaults.set(status.rawValue, forKey: "luisStatus")
        case 1:
            userDefaults.set(status.rawValue, forKey: "ninaStatus")
        case 2:
            userDefaults.set(status.rawValue, forKey: "rafaelStatus")
        default: return
        }

        if status == .preparing {
            startActivity(courier: couriers[index])
        } else if status == .end {
            endActivity(courier: couriers[index])
        } else {
            updateActivity(courier: couriers[index])
        }
    }

    func incrementPizzaCount(index: Int) {
        guard index < couriers.count else { return }
        couriers[index].incrementPizzaCount()

        switch index {
        case 0:
            userDefaults.set(couriers[index].pizzaCount, forKey: "luisPizzaCount")
        case 1:
            userDefaults.set(couriers[index].pizzaCount, forKey: "ninaPizzaCount")
        case 2:
            userDefaults.set(couriers[index].pizzaCount, forKey: "rafaelPizzaCount")
        default: return
        }

        updateActivity(courier: couriers[index])
    }

    func endAllActivities() {
        for i in 0..<couriers.count {
            couriers[i].status = .end
        }

        activityManager.endAll()
    }

    private func startActivity(courier: Courier) {
        Task {
            await activityManager.start(courierName: courier.name ?? "", courierImage: courier.image, count: courier.pizzaCount)
        }
    }

    private func updateActivity(courier: Courier) {
        activityManager.update(status: courier.status, count: courier.pizzaCount)
    }

    private func endActivity(courier: Courier) {
        activityManager.end(courierName: courier.name)
    }
}
