//
//  AnalyticsManager.swift
//
//  Created by Asya Atpulat on 29.10.2023.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    private init() {}
    
    static let shared = AnalyticsManager()
    
    public func log(_ event: AnalyticsEvent) {
        var parameters: [String: Any] = [:]
        switch event {
        case .cellSelected(let cellSelectedEvent):
            do {
                let data = try JSONEncoder().encode(cellSelectedEvent)
                let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                parameters = dict
            } catch {
                
            }
        }
        print("\n Event: \(event.eventName) Params: \(parameters)")
        Analytics.logEvent(event.eventName, parameters: parameters)
    }
}

enum AnalyticsEvent {
    case cellSelected(CellSelectedEvent)
    
    var eventName: String {
        switch self {
        case.cellSelected: return "cell_selected"
        }
    }
}

struct CellSelectedEvent: Codable {
    let cellTitle: String
}
