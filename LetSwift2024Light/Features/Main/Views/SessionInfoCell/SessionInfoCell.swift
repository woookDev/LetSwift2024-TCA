//
//  SessionInfoCell.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

import Then
import ComposableArchitecture

final class SessionInfoCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var store: StoreOf<SessionInfoCellReducer>?
    
    // MARK: - UI Components
    
    private let backgroundCardView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let sessionTimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .semibold)
        $0.textColor = .systemGray
    }
    
    private let sessionTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkText
        $0.numberOfLines = 0
    }
    
    private let speakerNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .darkGray
    }
    
    private lazy var completionCheckButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "app.badge.checkmark"), for: .normal)
        $0.tintColor = .darkGray
        $0.addTarget(self, action: #selector(didTapCompletionCheckButton), for: .touchUpInside)
    }
    
    // MARK: - Initializers
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension SessionInfoCell {
    @objc private func didTapCompletionCheckButton() {
        store?.send(.didTapCompleteButton)
    }
    
    private func setCompletionCheckButtonSelected(isSelected: Bool) {
        if isSelected {
            completionCheckButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            completionCheckButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
}

// MARK: - Internal Methods

extension SessionInfoCell {
    func configure(store: StoreOf<SessionInfoCellReducer>) {
        self.store = store
        store.withState { [weak self] state in
            guard let self else { return }
            self.sessionTimeLabel.text = state.info.time
            self.sessionTitleLabel.text = state.info.title
            self.speakerNameLabel.text = state.info.speakerInfo.name
            setCompletionCheckButtonSelected(isSelected: state.isComplete)
        }
    }
}

// MARK: - SetupUI
extension SessionInfoCell {
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubviews(
            backgroundCardView.withSubviews(
                sessionTimeLabel,
                sessionTitleLabel,
                speakerNameLabel,
                completionCheckButton
            )
        )
        
        backgroundCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        sessionTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(10)
        }
        
        sessionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(sessionTimeLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(completionCheckButton.snp.leading).offset(-12)
        }
        
        speakerNameLabel.snp.makeConstraints {
            $0.top.equalTo(sessionTitleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        completionCheckButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(30)
        }
    }
}
