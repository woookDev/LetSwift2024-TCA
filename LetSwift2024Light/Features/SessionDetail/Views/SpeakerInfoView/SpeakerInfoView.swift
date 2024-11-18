//
//  SpeakerInfoView.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

import Then

final class SpeakerInfoView: UIView {
    
    // MARK: - UI Components
    
    private let speakerProfileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    private lazy var infoStackView = UIStackView(arrangedSubviews: [
        speakerNameLabel,
        speakerDescriptionLabel,
        linkStackView
    ]).then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let speakerNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: .init(16), weight: .bold)
        $0.textColor = .white
    }
    
    private let speakerDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: .init(10), weight: .medium)
        $0.numberOfLines = 0
        $0.textColor = .systemGray3
    }
    
    private let linkStackView = UIStackView().then {
        $0.axis = .horizontal
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
extension SpeakerInfoView {
    func configure(with viewModel: SpeakerInfoViewModel) {
        speakerProfileImageView.image = UIImage(named: "profile_\(viewModel.id)")
        speakerNameLabel.text = viewModel.speakerName
        speakerDescriptionLabel.text = viewModel.speakerDescription
    }
}

// MARK: - SetupUI

extension SpeakerInfoView {
    private func setupUI() {
        addSubviews(
            speakerProfileImageView,
            infoStackView
        )
        
        speakerProfileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(speakerProfileImageView.snp.trailing).offset(12)
        }
    }
}
