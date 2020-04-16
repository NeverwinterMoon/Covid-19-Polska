//
//  Images.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

enum Images {
    static let confirmed = "thermometer"
    static let time = "clock"
    static let deaths = "heart.slash"
    static let recovered = "smiley"
    static let info = "info.circle"
    static let reload = "arrow.clockwise"
    static let calendar = "calendar"
}

struct IconView: View {
    var name: String
    var size: Image.Scale
    var color: Color
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular))
            .imageScale(size)
            .frame(width: 32, height: 32)
            .foregroundColor(color)
    }
}