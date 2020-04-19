//
//  LineView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 17/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

public struct LineView: View {
    @EnvironmentObject var chartViewModel: ChartViewModel
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
    
    public init(data: [Double],
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
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
                .frame(width: UIScreen.width, height: (UIScreen.height/1.75 - 40))
                .padding(.top, -50)
                    .padding(.bottom, 10)
            }
        .gesture(DragGesture()
        .onChanged({ value in
            self.dragLocation = value.location
            self.indicatorLocation = CGPoint(x: max(value.location.x,0), y: 0)
            self.opacity = 1
            self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width, height: (UIScreen.height/1.75 - 40))
            self.hideHorizontalLines = true
        })
            .onEnded({ value in
                self.opacity = 0
                self.hideHorizontalLines = false
            })
        )
        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x+24)/stepWidth))
        if (index >= 0 && index < points.count){
            self.selectedDay = Day(
                confirmed: chartViewModel.customData[index+1].confirmed,
                deaths: chartViewModel.customData[index+1].deaths,
                recovered: chartViewModel.customData[index+1].recovered,
                date: chartViewModel.customData[index+1].date)
            self.selectedDayIncrease = Day(
                confirmed: chartViewModel.getDailyIncrease(on: index+1, of: .confirmed),
                deaths: chartViewModel.getDailyIncrease(on: index+1, of: .deaths),
                recovered: chartViewModel.getDailyIncrease(on: index+1, of: .recovered),
                date: chartViewModel.customData[index+1].date
            )
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(data: [8,23,54,32,12,37,7,23,43], title: "Full chart", style: Styles.lineChartStyleOne).environmentObject(ChartViewModel())
    }
}

