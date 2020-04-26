//
//  Images.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

enum Icons {
    static let confirmed = "thermometer"
    static let time = "clock"
    static let deaths = "heart.slash"
    static let recovered = "smiley"
    static let info = "info.circle"
    static let reload = "arrow.clockwise"
    static let calendar = "calendar"
    static let active = "bed.double"
    static let percent = "percent"
    static let bars = "chart.bar"
    static let more = "ellipsis"
    static let increase = "arrow.up.right"
    static let dismiss = "xmark"
    static let expand = "arrow.down"
    static let collapse = "arrow.up"
    static let table = "table"
    static let back = "arrow.turn.up.left"
    static let hide = "chevron.down"
}

struct IconView: View {
    var name: String
    var size: Image.Scale
    var weight: Font.Weight
    var color: Color
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: weight))
            .imageScale(size)
            .frame(width: 32, height: 32)
            .foregroundColor(color)
    }
}
