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
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var currentDate: String = ""
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
                     currentValue: self.$currentDataNumber,
                     currentDate: self.$currentDate,
                     showBackground: true
                )
                .frame(width: UIScreen.screenWidth, height: (UIScreen.screenHeight/1.75 - 50))
                .padding(.top, -50)
            }
        .gesture(DragGesture()
        .onChanged({ value in
            self.dragLocation = value.location
            self.indicatorLocation = CGPoint(x: max(value.location.x,0), y: 0)
            self.opacity = 1
            self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width, height: (UIScreen.screenHeight/1.75 - 50))
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
            self.currentDataNumber = points[index]
            self.currentDate = chartViewModel.customData[index].date
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

