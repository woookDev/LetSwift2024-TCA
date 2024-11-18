//
//  MainViewController.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//


import UIKit
import Combine

import ComposableArchitecture
import SnapKit
import Then

// MARK: - TrackType

enum TrackType: String {
    case trackA = "a"
    case trackB = "b"
}

final class MainViewController: UIViewController {
    // MARK: - Constants
    
    enum Section: Int {
        case sessions
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SessionInfoCellReducer.State>
    typealias DataSource = UITableViewDiffableDataSource<Section, SessionInfoCellReducer.State>
    
    // MARK: - Properties
    
    @UIBindable private var store: StoreOf<MainReducer>

    private lazy var dataSource = DataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, info in
        guard let cellStore = self?.store.scope(state: \.cellItems[id: info.id], action: \.cellAction[id: info.id])
        else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(
            withCellClass: SessionInfoCell.self,
            indexPath: indexPath
        )
        
        cell.configure(store: cellStore)
        return cell
    })
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    
    private let mainHeader = MainHeaderView()
    
    private lazy var tableView = UITableView(
        frame: .zero, style: .grouped
    ).then {
        $0.register(type: SessionInfoCell.self)
        $0.register(headerFooterViewClass: SessionHeaderView.self)
        $0.tableHeaderView = mainHeader
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Initializers
    
    init(store: StoreOf<MainReducer>) {
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
        initialTabLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        resetLayoutForHeader()
    }
}

// MARK: - Private Methods
extension MainViewController {
    private func setupTableView(items: [SessionInfoCellReducer.State]) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.sessions])
        snapshot.appendItems(items)
        dataSource.apply(
            snapshot, animatingDifferences: false
        )
    }
    
    private func initialTabLoad() {
        store.send(.sessionHeader(.didTapTrackButton(.trackA)))
    }
    
    private func resetLayoutForHeader() {
        guard let headerView = tableView.tableHeaderView else { return }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
        }
    }
}

// MARK: - Binding

extension MainViewController {
    private func bind() {
        store.publisher.compactMap(\.cellItems)
            .removeDuplicates()
            .sink { [weak self] items in
                self?.setupTableView(items: items.elements)
            }
            .store(in: &cancellables)
        
        store.publisher.compactMap(\.selectedTrackType)
            .removeDuplicates()
            .sink { [weak self] type in
                let headerView = self?.tableView.headerView(forSection: 0) as? SessionHeaderView
                headerView?.setType(type: type)
            }
            .store(in: &cancellables)
        
        store.$completedSessions.publisher
            .removeDuplicates()
            .sink { [weak self] completedSessions in
                self?.store.send(.checkSessionCompletion(completedSessions))
            }
            .store(in: &cancellables)
        
        present(item: $store.scope(state: \.alert, action: \.alert)) { store in
          UIAlertController(store: store)
        }
        
        navigationDestination(
            item: $store.scope(state: \.sessionDetail, action: \.sessionDetail)
        ) { store in
            SessionDetailViewController(store: store)
        }
    }
}


// MARK: - SetupUI

extension MainViewController {
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withClass: SessionHeaderView.self
        )
        let headerStore = store.scope(
            state: \.sessionHeader, action: \.sessionHeader
        )
        headerView.configure(with: headerStore)
        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let cellData = dataSource.itemIdentifier(for: indexPath) {
            store.send(.didSelectSessionCell(cellData))
        }
    }
}
