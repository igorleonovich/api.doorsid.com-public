//
//  PlanFeature.swift
//  
//
//  Created by Igor Leonovich on 26.07.21
//  Copyright © 2021 FT. All rights reserved.
//

import Foundation

enum PlanFeature: String, Codable {
    
    // Default
    static let elementList = PlanFeature.plan
    case plan
    
    // Markup
    case actionsPoints, dates, byTime, byTopic, byX, levels
    
    // Representing
    case fullTreeView, asterisksNumbers
    
    // Advanced Representing
    case cardTableView
    
    // Controlling
    case actionDelegating
    
    // Auto Insert (from: Boards, Bank, etc.)
    case autoInsert
    
    // Cross-Integration: Cross-Dependency, Duplication Avoiding
    case crossIntegration
}


extension PlanFeature {
    
    func requiredFeatures() -> [PlanFeature] {
        switch self {
        case .plan:
            return [.elementList]
        case .actionsPoints:
            return [.elementList]
        case .dates:
            return [.elementList]
        case .byTime:
            return [.elementList, .byX]
        case .byTopic:
            return [.elementList, .byX]
        case .byX:
            return [.elementList]
        case .levels:
            return [.elementList]
        case .fullTreeView, .asterisksNumbers:
            return [.elementList]
        case .cardTableView:
            return [.elementList]
        default:
            return [.elementList]
        }
    }
}
