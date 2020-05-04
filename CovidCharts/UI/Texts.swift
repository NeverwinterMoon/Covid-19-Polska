//
//  Texts.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 04/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct SampleTexts: View {
    var body: some View {
        VStack {
            SectionTitleText("Sample title")
            
        }
    }
}

struct SampleTexts_Previews: PreviewProvider {
    static var previews: some View {
        SampleTexts()
    }
}

struct SectionTitleText: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
        .font(.system(size: 32, weight: .semibold, design: .rounded))
        .foregroundColor(Colors.label)
    }
}

struct StatisticsValueText: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
        
    }
    
    var body: some View {
        Text(text)
        .font(.system(size: 16, weight: .semibold, design: .rounded))
    }
}

