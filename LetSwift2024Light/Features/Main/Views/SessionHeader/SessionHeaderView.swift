//
//  SessionHeaderView.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

import Then
import ComposableArchitecture

final class SessionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    private var store: StoreOf<SessionHeaderReducer>?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "Sessions"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [
        trackASessionButton,
        trackBSessionButton
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private lazy var trackASessionButton = UIButton(type: .system).then {
        $0.setTitle("Track A", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(tapTrackAButton), for: .touchUpInside)
    }
    
    private lazy var trackBSessionButton = UIButton(type: .system).then {
        $0.setTitle("Track B", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(tapTrackBButton), for: .touchUpInside)
    }
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

extension SessionHeaderView {
    @objc private func tapTrackAButton() {
        store?.send(.didTapTrackButton(.trackA))
    }
    
    @objc private func tapTrackBButton() {
        store?.send(.didTapTrackButton(.trackB))
    }
}

// MARK: - Internal Methods

extension SessionHeaderView {
    func configure(with store: StoreOf<SessionHeaderReducer>) {
        self.store = store
        store.withState { [weak self] state in
            guard let self, let type = state.selectedType else { return }
            self.setType(type: type)
        }
    }
    
    func setType(type: TrackType) {
        switch type {
        case .trackA:
            trackASessionButton.backgroundColor = .white
            trackASessionButton.setTitleColor(.black, for: .normal)
            trackBSessionButton.backgroundColor = .black
            trackBSessionButton.setTitleColor(.white, for: .normal)
        case .trackB:
            trackBSessionButton.backgroundColor = .white
            trackBSessionButton.setTitleColor(.black, for: .normal)
            trackASessionButton.backgroundColor = .black
            trackASessionButton.setTitleColor(.white, for: .normal)
        }
    }
}

// MARK: - SetupUI

extension SessionHeaderView {
    private func setupUI() {
        addSubviews(
            titleLabel,
            buttonStackView
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
