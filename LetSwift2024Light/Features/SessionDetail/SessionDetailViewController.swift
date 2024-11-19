//
//  SessionDetailViewController.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit
import Combine

import SnapKit
import Then
import ComposableArchitecture

final class SessionDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let store: StoreOf<SessionDetailReducer>
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    
    private let backgroundScrollView = UIScrollView()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        detailInfoView,
        speakerTitleView,
        speakerInfoView
    ]).then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let detailInfoView = SessionDetailInfoView()
    
    private let speakerTitleView = SessionDetailTitleView().then {
        $0.setTitle(with: "Speaker")
    }
    
    private let speakerInfoView = SpeakerInfoView()
    
    // MARK: - Initializers
    
    init(store: StoreOf<SessionDetailReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
}

// MARK: - Binding

extension SessionDetailViewController {
    func bind() {
        store.publisher.sessionDetailInfoViewModel
            .removeDuplicates()
            .sink { [weak self] viewModel in
                let store = Store(initialState: SessionDetailInfoReducer.State(viewModel: viewModel)) {
                    SessionDetailInfoReducer()
                }
                self?.detailInfoView.configure(with: store)
            }
            .store(in: &cancellables)
        
        store.publisher.speakerInfoViewModel
            .removeDuplicates()
            .sink { [weak self] viewModel in
                self?.speakerInfoView.configure(with: viewModel)
            }
            .store(in: &cancellables)
    }
}

// MARK: - SetupUI

extension SessionDetailViewController {
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubviews(
            backgroundScrollView.withSubviews(stackView)
        )
        
        backgroundScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(backgroundScrollView.contentLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
    }
}
