//
//  Line.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 17/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

public struct Line: View {
    var indicator = IndicatorPoint()
    @ObservedObject var data: ChartData
    @Binding var touchLocation: CGPoint
    @Binding var showIndicator: Bool
    @Binding var minDataValue: Double?
    @Binding var maxDataValue: Double?
    @Binding var selectedDay: Day
    @Binding var selectedDayIncrease: Day
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    
    var gradient: GradientColor = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    var index:Int = 0
    var curvedLines: Bool = true
    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return (UIScreen.width-32) / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        let points = self.data.onlyPoints()
        if minDataValue != nil && maxDataValue != nil {
            min = minDataValue!
            max = maxDataValue!
        }else if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        }else {
            return 0
        }
        if let min = min, let max = max, min != max {
                return ((UIScreen.height/1.75 - 50) - 50) / CGFloat(max)
        }
        return 0
    }
    var path: Path {
        let points = self.data.onlyPoints()
        return curvedLines ? Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue) : Path.linePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    var closedPath: Path {
        let points = self.data.onlyPoints()
        return curvedLines ? Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue) : Path.closedLinePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    
    public var body: some View {
        ZStack {
            if(self.showFull && self.showBackground){
                self.closedPath
                    .fill(LinearGradient(gradient: Gradient(colors: [Colors.graphGradient, Colors.customViewBackground]), startPoint: .bottom, endPoint: .top))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .transition(.opacity)
                    .animation(.easeIn(duration: 1.6))
            }
            self.path
                .trim(from: 0, to: self.showFull ? 1:0)
                .stroke(LinearGradient(gradient: gradient.getGradient(), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
                .onAppear {
                    self.showFull = true
            }
            .onDisappear {
                self.showFull = false
            }
            .drawingGroup()
            if(self.showIndicator) {
                indicator
                    .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                VStack (alignment: .leading, spacing: 4) {
                    IndicatorTitleView(title: selectedDay.date.formattedDate(.long), textColor: Colors.main)
                    IndicatorTextLine(parameter: "Zakażenia", currentValue: selectedDayIncrease.confirmed)
                    IndicatorTextLine(parameter: "Zgony", currentValue: selectedDayIncrease.deaths)
                    Spacer()
                    .frame(height: 4)
                    IndicatorTitleView(title: "Łącznie", textColor: Colors.main)
                    IndicatorTextLine(parameter: "Zakażenia", currentValue: selectedDay.confirmed)
                    IndicatorTextLine(parameter: "Zgony", currentValue: selectedDay.deaths)
                }
                .frame(width: 150, height: 145, alignment: .leading)
                .background(Colors.customViewBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
                .offset(x: 0, y: 85)
            }
        }
    }
    
    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let closest = self.path.point(to: touchLocation.x)
        return closest
    }
    
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Line(data: ChartData(points: [12,-230,10,54]), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil), selectedDay: .constant(Day(confirmed: 1231, deaths: 123, recovered: 12, date: "3 March 2019")), selectedDayIncrease: .constant(Day(confirmed: 50, deaths: 50, recovered: 50, date: "3 March 2019")))
        }.frame(width: UIScreen.width, height: UIScreen.height/2)
    }
}

struct IndicatorTitleView: View {
    
    var title: String
    var textColor: Color
    
    var body: some View {
        Text(title)
            .font(Fonts.indicatorTitle)
            .foregroundColor(textColor)
            .padding(.horizontal)
    }
}

struct IndicatorTextLine: View {
    
    var parameter: String
    var currentValue: Int
    
    var body: some View {
        HStack {
            Text("\(parameter): ")
                .foregroundColor(Colors.label).foregroundColor(Colors.label)
                .font(Fonts.indicatorTextRegular)
            Spacer()
            Text("\(Int(currentValue))")
                .foregroundColor(Colors.label)
                .font(Fonts.indicatorTextBolded)
        }
        .padding(.horizontal)
    }
}
