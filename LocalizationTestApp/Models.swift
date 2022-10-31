import Foundation

enum Value1Type: Int {
    case kilometers
    case meters
    case millimeters
    
    func getUnitLength() -> UnitLength {
        switch self {
        case .kilometers:
            return .kilometers
        case .meters:
            return .meters
        case .millimeters:
            return .millimeters
        }
    }
}

enum Value2Type: Int {
    case miles
    case yards
    case feet
    
    func getUnitLength() -> UnitLength {
        switch self {
        case .miles:
            return .miles
        case .yards:
            return .yards
        case .feet:
            return .feet
        }
    }
}
