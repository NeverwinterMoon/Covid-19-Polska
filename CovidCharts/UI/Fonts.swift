//
//  Fonts.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 19/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

enum Fonts {
    static let text = Font.system(size: 16, weight: .regular, design: .rounded)
    static let icon = Font.system(size: 12, weight: .semibold, design: .rounded)
    static let button = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let popupTitle = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let indicatorTitle = Font.system(size: 14, weight: .semibold, design: .rounded)
    static let indicatorTextRegular = Font.system(size: 11, weight: .regular, design: .rounded)
    static let indicatorTextBolded = Font.system(size: 11, weight: .semibold, design: .rounded)
    static let title = Font.system(size: 26, weight: .bold, design: .rounded)
    static let listSectionTitle = Font.system(size: 20, weight: .bold, design: .rounded)
    static let listElement = Font.system(size: 11, weight: .semibold, design: .rounded)
    static let listElementDetails = Font.system(size: 9, weight: .semibold, design: .rounded)
}
