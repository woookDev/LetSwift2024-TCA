//
//  MainHeaderView.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

import SnapKit
import Then

final class MainHeaderView: UIView {
    
    // MARK: - UI Components
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(imageKey: .mainLogo)
        $0.contentMode = .scaleAspectFit
    }
    
    private let scheduleTitleLabel = UILabel().then {
        $0.text = "행사 일자"
        $0.font = .systemFont(ofSize: .init(16), weight: .bold)
        $0.textColor = .white
    }
    
    private let scheduleInfoLabel = UILabel().then {
        $0.text = "2024년 11월 25일 월요일"
        $0.font = .systemFont(ofSize: .init(14), weight: .semibold)
        $0.textColor = .white
    }
    
    private let placeTitleLabel = UILabel().then {
        $0.text = "행사장"
        $0.font = .systemFont(ofSize: .init(16), weight: .bold)
        $0.textColor = .white
    }
    
    private let placeInfoLabel = UILabel().then {
        $0.text = "서울 광진구 능동로 209 세종대학교 컨벤션홀"
        $0.font = .systemFont(ofSize: .init(14), weight: .semibold)
        $0.textColor = .white
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

// MARK: - SetupUI

extension MainHeaderView {
    private func setupUI() {
        backgroundColor = .black
        addSubviews(
            logoImageView,
            scheduleTitleLabel,
            scheduleInfoLabel,
            placeTitleLabel,
            placeInfoLabel
        )
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 60))
        }
        
        scheduleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        scheduleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        placeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleInfoLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        placeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(placeTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
