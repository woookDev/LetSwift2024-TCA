//
//  SessionDetailInfoView.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit
import Combine

import Then
import SnapKit
import ComposableArchitecture

final class SessionDetailInfoView: UIView {
    
    // MARK: - Properties
    
    private var store: StoreOf<SessionDetailInfoReducer>?
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    
    private let timeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .systemGray5
        $0.numberOfLines = 0
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private lazy var completionCheckButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = .systemCyan
        $0.addTarget(self, action: #selector(didTapCompletionCheckButton), for: .touchUpInside)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Binding
extension SessionDetailInfoView {
    private func bind() {
        guard let store else { return }
        store.$completedSessions.publisher
            .sink { [weak self] completedSessions in
                self?.setCompletionCheckButtonSelected(isSelected: completedSessions.contains(store.viewModel.id))
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private Methods

extension SessionDetailInfoView {
    @objc private func didTapCompletionCheckButton() {
        store?.send(.didTapCompleteButton)
    }
    
    private func setCompletionCheckButtonSelected(isSelected: Bool) {
        if isSelected {
            completionCheckButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            completionCheckButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
}

// MARK: - Internal Methods

extension SessionDetailInfoView {
    func configure(with store: StoreOf<SessionDetailInfoReducer>) {
        self.store = store
        store.withState { state in
            titleLabel.text = state.viewModel.title
            timeLabel.text = state.viewModel.time
            setCompletionCheckButtonSelected(
                isSelected: state.completedSessions.contains(state.viewModel.id)
            )
        }
        bind()
    }
}

// MARK: - SetupUI

extension SessionDetailInfoView {
    private func setupUI() {
        backgroundColor = .black
        addSubviews(
            titleLabel,
            timeLabel,
            completionCheckButton
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(completionCheckButton.snp.leading).offset(-14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(completionCheckButton.snp.leading).offset(-14)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        completionCheckButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(100)
        }
    }
}
