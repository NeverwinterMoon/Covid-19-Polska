//
//  Ext-String.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import UIKit

enum DateStyle {
    case dayMonth
    case dayMonthYear
}

extension String {
    func formattedDate(_ style: DateStyle) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: self)
        let secondFormatter = DateFormatter()
        secondFormatter.locale = Locale(identifier: "pl_PL")
        switch style {
        case .dayMonth: secondFormatter.dateFormat = "dd.MM"
        case .dayMonthYear: secondFormatter.dateFormat = "dd MMMM YYYY"
        }
        return secondFormatter.string(from: date ?? Date())
    }
    
}
