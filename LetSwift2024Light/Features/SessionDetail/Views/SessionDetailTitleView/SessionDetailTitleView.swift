//
//  SessionDetailTitleView.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

import Then

final class SessionDetailTitleView: UIView {
    
    // MARK: - UI Components
    
    private let speakerInfoTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let bottomLineView = UIView().then {
        $0.backgroundColor = .white
    }
   
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal Methods

extension SessionDetailTitleView {
    func setTitle(with title: String) {
        speakerInfoTitleLabel.text = title
    }
}

// MARK: - SetupUI

extension SessionDetailTitleView {
    private func setupUI() {
        addSubviews(
            speakerInfoTitleLabel,
            bottomLineView
        )
        
        speakerInfoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.top.equalTo(speakerInfoTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
}
