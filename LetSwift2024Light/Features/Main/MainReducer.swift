//
//  MainReducer.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import ComposableArchitecture

// MARK: - MainError

enum MainError: Error {
    case loadJSONError
    
    var localizedDescription: String {
        return "트랙별 세션 데이터 로드에 실패하였습니다"
    }
}

// MARK: - MainReducer

@Reducer
struct MainReducer {
    // MARK: - Dependencies

    @Dependency(\.mainClient) var mainClient: MainClient

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        @Presents var sessionDetail: SessionDetailReducer.State?
        @Presents public var alert: AlertState<Action.Alert>?
        
        var selectedTrackType: TrackType?
        var cellItems: IdentifiedArrayOf<SessionInfoCellReducer.State> = []
        var sessionHeader: SessionHeaderReducer.State = .init()
        
        @Shared(
            .fileStorage(.documentsDirectory.appendingPathComponent(FileStorageKeys.completedSessions.rawValue))
        )
        var completedSessions: Set<Int> = []
    }

    // MARK: - Action

    enum Action {
        public enum Alert: Equatable, Sendable {}
        
        case alert(PresentationAction<Alert>)
        case receiveData(
            TaskResult<IdentifiedArrayOf<SessionInfoCellReducer.State>>
        )
        case cellAction(IdentifiedActionOf<SessionInfoCellReducer>)
        case didSelectSessionCell(SessionInfoCellReducer.State)
        case sessionDetail(PresentationAction<SessionDetailReducer.Action>)
        case sessionHeader(SessionHeaderReducer.Action)
        case checkSessionCompletion(Set<Int>)
    }
    
    // MARK: - Reducer

    var body: some Reducer<State, Action> {
        
        Scope(state: \.sessionHeader, action: \.sessionHeader) {
            SessionHeaderReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .receiveData(let .success(items)):
                state.cellItems = items
                return .none
            case .receiveData(let .failure(error)):
                state.alert = AlertState { TextState(error.localizedDescription)
                }
                return .none
            case .cellAction(.element(let id, let action)):
                switch action {
                case .didTapCompleteButton:
                    if state.completedSessions.contains(id) {
                        state.completedSessions.remove(id)
                    } else {
                        state.completedSessions.insert(id)
                    }
                    return .none
                }
            case .didSelectSessionCell(let cellData):
                state.sessionDetail = SessionDetailReducer.State(
                    sessionDetailInfoViewModel: .init(
                        id: cellData.id,
                        title: cellData.info.title,
                        time: cellData.info.time
                    ),
                    speakerInfoViewModel: .init(
                        id: cellData.id,
                        speakerName: cellData.info.speakerInfo.name ?? "",
                        speakerDescription: cellData.info.speakerInfo.description ?? ""
                    )
                )
                return .none
            case .sessionHeader(.didTapTrackButton(let type)):
                state.selectedTrackType = type
                state.sessionHeader = .init(selectedType: type)
                return .run { [state] send in
                    do {
                        if let trackInfo = try await self.mainClient.fetchTrackInfo(type.rawValue) {
                            await send(
                                .receiveData(.success(makeCellItems(trackInfo: trackInfo, completedSessions: state.completedSessions)))
                            )
                        } else {
                            await send(
                                .receiveData(.failure(MainError.loadJSONError))
                            )
                        }
                    } catch {
                        await send(
                            .receiveData(.failure(MainError.loadJSONError))
                        )
                    }
                }
            case .checkSessionCompletion(let completedSessions):
                state.cellItems = checkCompletedSessions(
                    cellItems: state.cellItems.elements,
                    completedSessions: completedSessions
                )
                return .none
            default:
                return .none
            }
        }
        .forEach(\.cellItems, action: \.cellAction) {
            SessionInfoCellReducer()
        }
        .ifLet(\.$sessionDetail, action: \.sessionDetail) {
            SessionDetailReducer()
        }
    }
}

// MARK: - Private Method

extension MainReducer {
    private func makeCellItems(trackInfo: TrackInfo, completedSessions: Set<Int>) -> IdentifiedArrayOf<SessionInfoCellReducer.State> {
        let sessionList = trackInfo.sessionInfoList.map { session in
            SessionInfoCellReducer.State(id: session.id, info: session, isComplete: completedSessions.contains(session.id))
        }
        
        return IdentifiedArrayOf(uniqueElements: sessionList)
    }
    
    private func checkCompletedSessions(cellItems: [SessionInfoCellReducer.State], completedSessions: Set<Int>) -> IdentifiedArrayOf<SessionInfoCellReducer.State> {
        let checkedItems = cellItems.map { state in
            return SessionInfoCellReducer.State(
                id: state.id,
                info: state.info,
                isComplete: completedSessions.contains(state.id)
            )
        }
        
        return IdentifiedArrayOf(uniqueElements: checkedItems)
    }
}
