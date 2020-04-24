//
//  LineView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 17/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

public struct LineView: View {
    @EnvironmentObject var vm: ChartViewModel
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier:String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity: Double = 0
    @State private var selectedDay: Day = Day(confirmed: 0, deaths: 0, recovered: 0, date: "")
    @State private var selectedDayIncrease: Day = Day(confirmed: 0, deaths: 0, recovered: 0, date: "")
    @State private var hideHorizontalLines: Bool = false
    
    public init(chartData: ChartData,
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                valueSpecifier: String? = "%.1f") {
        self.data = chartData
        self.title = title
        self.legend = legend
        self.style = style
        self.valueSpecifier = valueSpecifier!
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                Line(data: self.data,
                     touchLocation: self.$indicatorLocation,
                     showIndicator: self.$hideHorizontalLines,
                     minDataValue: .constant(0),
                     maxDataValue: .constant(nil),
                     selectedDay: self.$selectedDay,
                     selectedDayIncrease: self.$selectedDayIncrease,
                     showBackground: true
                )
                    .frame(width: ChartView.width, height: (ChartView.height - 40))
                .padding(.top, -50)
                    .padding(.bottom, 10)
            }
        .gesture(DragGesture()
        .onChanged({ value in
            self.dragLocation = value.location
            self.indicatorLocation = CGPoint(x: max(value.location.x,0), y: 0)
            self.opacity = 1
            self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: ChartView.width, height: (ChartView.height - 40))
            self.hideHorizontalLines = true
            self.vm.showHighlightedData = true
        })
            .onEnded({ value in
                self.opacity = 0
                self.hideHorizontalLines = false
                self.vm.showHighlightedData = false
            })
        )
        }
    }
    
    #warning("need to fix this indicator")
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        var index: Int = Int(floor((toPoint.x+15)/stepWidth))
        if index > 0 && index < points.count {
            if index == vm.dailyData.count {
                index = index - 1
            }
//            self.vm.highlightedData = ChartHighlightedData(confirmed: vm.customData[index].confirmed, deaths: <#T##String#>, recovered: <#T##String#>, confirmedInc: <#T##String#>, deathsInc: <#T##String#>, recoveredInc: <#T##String#>, date: <#T##String#>)
//            self.vm.highlightedData = ChartHighlightedData(
//                confirmed: vm.customData[index].confirmed,
//                deaths: vm.customData[index].deaths,
//                recovered: vm.customData[index].recovered,
//                confirmedInc: : vm.getDailyIncrease(on: index, of: .confirmed),
//                deathsInc: vm.getDailyIncrease(on: index, of: .deaths),
//                recoveredInc: vm.getDailyIncrease(on: index, of: .recovered),
//                date: vm.customData[index].date)

            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index-1])*stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(chartData: ChartData(points: [2,8,10,14,18,23,12,8,2]), title: "Full chart", style: Styles.lineChartStyleOne).environmentObject(ChartViewModel())
    }
}

