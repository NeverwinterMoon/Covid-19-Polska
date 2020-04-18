//
//  Ext-String.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import UIKit

extension String {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: self)
        let secondFormatter = DateFormatter()
        secondFormatter.dateFormat = "dd.MM"
        return secondFormatter.string(from: date ?? Date())
    }
    
    func formattedToShortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        formatter.timeZone = .current
        let date = formatter.date(from: self)
        return date!.toShortString()
    }
    
}
