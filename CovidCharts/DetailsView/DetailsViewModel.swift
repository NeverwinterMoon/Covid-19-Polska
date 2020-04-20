//
//  DetailsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    
    
    @Published var customData = [Day]()
    @Published var chart: ChartType = .confirmed
    
    
}

