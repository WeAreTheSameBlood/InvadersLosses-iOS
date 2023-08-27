//
//  Formatter.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import Foundation


public func formatDateToIso(dateInStr: String) -> String {
    
    let sourceFormatter = DateFormatter()
    sourceFormatter.dateFormat = "yyyy-MM-dd"
    
    let targetFormatter = DateFormatter()
    targetFormatter.dateFormat = "dd.MM.yyyy"
    
    if let date = sourceFormatter.date(from: dateInStr) {
        return targetFormatter.string(from: date)
    } else {
        return "00.00.0000"
    }
}
