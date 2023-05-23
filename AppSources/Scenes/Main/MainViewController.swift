//
//  MainViewController.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        view.addSubview(endAllButton)
        return view
    }()
    
    private lazy var endAllButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (view.bounds.width - 150) / 2, y: 0, width: 150, height: 50))
        button.setTitle("End All Activities", for: .normal)
        button.setImage(UIImage(systemName: "endAll"), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        button.backgroundColor = UIColor(named: "MexicanRed")
        button.tintColor = .white
        button.cornerRadius(radius: 5)
        return button
    }()

    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()

        tableView.register(CourierCell.self, forCellReuseIdentifier: "CourierCell")
        tableView.dataSource = self
        
        tableView.tableFooterView = footerView
        endAllButton.addTarget(self, action: #selector(endAllTapped), for: .touchUpInside)
    }

    func setupViews() {
        view.backgroundColor = UIColor(named: "ChaosBlack")
        view.addSubview(tableView)
        tableView.keyboardDismissMode = .interactive
    }

    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension MainViewController {
    @objc private func endAllTapped() {
        viewModel?.endAllActivities()
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourierCell", for: indexPath) as? CourierCell, let courier = viewModel?.getCourier(indexPath.row) {
            cell.configure(courier)
            cell.updateStatusHandler = { [weak self] status in
                self?.viewModel?.updateStatus(index: indexPath.row, status: status)
            }
            cell.addPizzaHandler = {
                self.viewModel?.incrementPizzaCount(index: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            return cell
        }
        return .init()
    }
}
