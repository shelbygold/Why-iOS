//
//  Why.swift
//  Why iOS?
//
//  Created by shelby gold on 3/20/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation

struct Why: Codable{
    let name: String
    let cohort: String
    let reason: String
}

extension Why {
    init?(dict: [String:Any]) {
        guard let name = dict["name"] as? String,
        let cohort = dict["cohort"] as? String,
            let reason = dict["reason"] as? String else {return nil}
        
        self.cohort = cohort
        self.reason = reason
        self.name = name
    }
    var asJSONDict: [String:Any] {
        return["name": self.name, "cohort": self.cohort, "reason": self.reason]
    }
    var asData: Data? {
        return (try? JSONSerialization.data(withJSONObject: asJSONDict, options: .prettyPrinted))
    }
}
