//
//  StorePublisher+Extensions.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import Combine
import ComposableArchitecture

// MARK: - Pulse

public struct Pulse<Value: Equatable>: Equatable {
    public var value: Value {
        didSet {
            riseValueUpdatedCount()
        }
    }

    public internal(set) var valueUpdatedCount = UInt.min

    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    public var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    public var projectedValue: Pulse<Value> {
        self
    }

    private mutating func riseValueUpdatedCount() {
        if valueUpdatedCount == UInt.max {
            valueUpdatedCount = UInt.min
        } else {
            valueUpdatedCount += 1
        }
    }
}

extension StorePublisher {
    public func pulse<Value>(_ keyPath: KeyPath<State, Pulse<Value>>) -> AnyPublisher<Value, Never> {
        map { state in
            state[keyPath: keyPath]
        }
        .removeDuplicates(by: { oldPulse, newPulse in
            oldPulse.valueUpdatedCount == newPulse.valueUpdatedCount
        })
        .map { pulse in
            pulse.value
        }
        .eraseToAnyPublisher()
    }
}
