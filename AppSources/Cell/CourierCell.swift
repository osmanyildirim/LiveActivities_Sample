//
//  CourierCell.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit

// swiftlint:disable all
final class CourierCell: UITableViewCell, BaseTableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DynamicBlack")
        view.cornerRadius(radius: 10)
        view.addSubview(nameLabel)
        view.addSubview(courierImageView)
        view.addSubview(buttonsStackView)
        view.addSubview(statusView)
        view.addSubview(addPizzaButton)
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = UIColor(named: "HokeyPokey")
        return label
    }()

    private lazy var courierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius(radius: 5)
        return imageView
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startButton, updateButton, endButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        button.backgroundColor = UIColor(named: "HippieBlue")
        button.cornerRadius(radius: 5)
        return button
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        button.backgroundColor = UIColor(named: "Dingley")
        button.cornerRadius(radius: 5)
        return button
    }()

    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle("End", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        button.backgroundColor = UIColor(named: "MexicanRed")
        button.cornerRadius(radius: 5)
        return button
    }()

    private lazy var addPizzaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Pizza", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        button.backgroundColor = UIColor(named: "HokeyPokey")
        button.tintColor = .white
        button.cornerRadius(radius: 5)
        return button
    }()

    private lazy var statusView: UIView = {
        let view = UIView()
        view.addSubview(availableImageView)
        view.addSubview(preparingImageView)
        view.addSubview(onTheRoadImageView)
        view.addSubview(deliveredImageView)

        view.addSubview(availableLabel)
        view.addSubview(preparingLabel)
        view.addSubview(onTheRoadLabel)
        view.addSubview(deliveredLabel)

        view.addSubview(currentStatusView)
        return view
    }()

    private lazy var availableImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: OrderStatus.available.imageName))
        return imageView
    }()

    private lazy var availableLabel: UILabel = {
        let label = UILabel()
        label.text = "Available"
        label.textColor = UIColor(named: "Ghost")
        label.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        return label
    }()

    private lazy var preparingImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: OrderStatus.preparing.imageName))
        return imageView
    }()

    private lazy var preparingLabel: UILabel = {
        let label = UILabel()
        label.text = "Preparing"
        label.textColor = UIColor(named: "Ghost")
        label.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        return label
    }()

    private lazy var onTheRoadImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: OrderStatus.onTheRoad.imageName))
        return imageView
    }()

    private lazy var onTheRoadLabel: UILabel = {
        let label = UILabel()
        label.text = "On the Road"
        label.textColor = UIColor(named: "Ghost")
        label.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        return label
    }()

    private lazy var deliveredImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: OrderStatus.delivered.imageName))
        return imageView
    }()

    private lazy var deliveredLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivered"
        label.textColor = UIColor(named: "Ghost")
        label.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        return label
    }()

    private lazy var currentStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "HokeyPokey")
        view.cornerRadius(radius: 2)
        return view
    }()

    private lazy var lastStatus = OrderStatus.available
    var updateStatusHandler: ((OrderStatus) -> Void)?
    var addPizzaHandler: (() -> Void)?

    override func prepareForReuse() {
        nameLabel.text?.removeAll()
        courierImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.backgroundColor = UIColor(named: "ChaosBlack")
        selectionStyle = .none
        contentView.addSubview(containerView)

        startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateButtonTap), for: .touchUpInside)
        endButton.addTarget(self, action: #selector(endButtonTap), for: .touchUpInside)
        addPizzaButton.addTarget(self, action: #selector(addPizzaButtonTap), for: .touchUpInside)
    }

    @objc private func startButtonTap() {
        startButton.isHidden = true
        updateButton.isHidden = false
        endButton.isHidden = false
//        containerView.addBorder(color: UIColor(named: "HokeyPokey"), width: 1)
        lastStatus = .preparing
        updateStatus()
    }

    @objc private func endButtonTap() {
        startButton.isHidden = false
        updateButton.isHidden = true
        endButton.isHidden = true
//        containerView.addBorder(color: .clear, width: 0.0)
        lastStatus = .end
        updateStatus()
    }

    @objc private func updateButtonTap() {
        switch lastStatus {
        case .preparing:
            lastStatus = .onTheRoad
        case .onTheRoad:
            lastStatus = .delivered
        default:
            return
        }

        updateStatus()
    }

    @objc private func addPizzaButtonTap() {
        addPizzaHandler?()
    }

    func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }

        courierImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
        }

        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(60)
        }

        [startButton, updateButton, endButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(60)
            }
        }

        statusView.snp.makeConstraints { make in
            make.top.equalTo(courierImageView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }

        availableImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }

        preparingImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(availableImageView.snp.top)
            make.leading.equalTo(availableImageView.snp.trailing).offset(50)
        }

        onTheRoadImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(preparingImageView.snp.top)
            make.leading.equalTo(preparingImageView.snp.trailing).offset(50)
        }

        deliveredImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(onTheRoadImageView.snp.top)
            make.leading.equalTo(onTheRoadImageView.snp.trailing).offset(50)
            make.trailing.equalToSuperview().inset(20)
        }

        availableLabel.snp.makeConstraints { make in
            make.top.equalTo(availableImageView.snp.bottom).offset(15)
            make.centerX.equalTo(availableImageView.snp.centerX)
        }

        preparingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(availableLabel.snp.centerY)
            make.centerX.equalTo(preparingImageView.snp.centerX)
        }

        onTheRoadLabel.snp.makeConstraints { make in
            make.centerY.equalTo(availableLabel.snp.centerY)
            make.centerX.equalTo(onTheRoadImageView.snp.centerX)
        }

        deliveredLabel.snp.makeConstraints { make in
            make.centerY.equalTo(availableLabel.snp.centerY)
            make.centerX.equalTo(deliveredImageView.snp.centerX)
        }

        currentStatusView.snp.makeConstraints { make in
            make.centerX.equalTo(availableImageView.snp.centerX)
            make.width.equalTo(70)
            make.height.equalTo(5)
            make.top.equalTo(availableLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }

        addPizzaButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
    }

    private func updateStatus() {
        var statusView = availableImageView

        switch lastStatus {
        case .available, .end:
            statusView = availableImageView
        case .preparing:
            statusView = preparingImageView
        case .onTheRoad:
            statusView = onTheRoadImageView
        case .delivered:
            statusView = deliveredImageView
            startButton.isHidden = true
            updateButton.isHidden = true
        }

        currentStatusView.snp.remakeConstraints { remake in
            remake.centerX.equalTo(statusView.snp.centerX)
            remake.width.equalTo(70)
            remake.height.equalTo(5)
            remake.top.equalTo(availableLabel.snp.bottom).offset(15)
            remake.bottom.equalToSuperview()
        }

        updateStatusHandler?(lastStatus)
    }

    private func initialUI() {
        switch lastStatus {
        case .available, .end:
            startButton.isHidden = false
            updateButton.isHidden = true
            endButton.isHidden = true
        case .preparing, .onTheRoad:
            startButton.isHidden = true
            updateButton.isHidden = false
            endButton.isHidden = false
        case .delivered:
            startButton.isHidden = true
            updateButton.isHidden = true
            endButton.isHidden = false
        }
    }
}

extension CourierCell {
    func configure(_ courier: Courier) {
        guard let name = courier.name else { return }

        courierImageView.image = UIImage(named: courier.image)
        nameLabel.text = "\(name) - \(courier.pizzaCount) Pizzas"
        lastStatus = courier.status
        initialUI()
        updateStatus()
        
//        if ![.available, .end].contains(courier.status) {
//            containerView.addBorder(color: UIColor(named: "HokeyPokey"), width: 1)
//        } else {
//            containerView.addBorder(color: .clear, width: 0)
//        }
    }
}
// swiftlint:disable all
