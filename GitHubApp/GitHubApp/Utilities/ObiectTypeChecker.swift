//
//  ObiectTypeChecker.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 30/07/2022.
//

import Foundation
import SwiftyJSON

struct ObjectTypeChecker {

    enum types {
        case typeString
        case typeInt
        case typeDouble
        case typeData
        case typeJSON
        case typeUnknown
    }

    func typeOfAny(variable: Any) -> types {
        if variable is String {return types.typeString}
        if variable is Int {return types.typeInt}
        if variable is Double {return types.typeDouble}
        if variable is Data {return types.typeData}
        if variable is JSON {return types.typeJSON}
        return types.typeUnknown
    }
    
}
