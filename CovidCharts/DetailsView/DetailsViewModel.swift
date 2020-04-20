//
//  DetailsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DailyData {
    var date: String
    var number: Int
}

class DetailsViewModel: ObservableObject {
    
    @Published var regionData: [RegionData]
    @Published var parameter: ParameterType
    @Published var data: [DailyData]
    
    init(regionData: [RegionData], data: [DailyData], parameter: ParameterType) {
        self.regionData = regionData
        self.data = data
        self.parameter = parameter
    }
    
}

