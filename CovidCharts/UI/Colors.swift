//
//  Colors.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

func logDebug(_ title: String, text: Any) {
    print("\(title): \(text)")
}

enum Colors {
    static let customViewBackground = Color("CustomViewBackground")
    static let appBackground = Color("AppBackground")
    static let graphGradient = Color("GraphGradient")
    static let mainColor = Color(hexString: "#76A9FF")
    static let color1:Color = Color(hexString: "#E2FAE7")
    static let color1Accent:Color = Color(hexString: "#72BF82")
    static let color2:Color = Color(hexString: "#EEF1FF")
    static let color2Accent:Color = Color(hexString: "#4266E8")
    static let color3:Color = Color(hexString: "#FCECEA")
    static let color3Accent:Color = Color(hexString: "#E1614C")
    static let OrangeEnd:Color = Color(hexString: "#FF782C")
    static let OrangeStart:Color = Color(hexString: "#EC2301")
    static let LegendText:Color = Color(hexString: "#A7A6A8")
    static let LegendColor:Color = Color(hexString: "#E8E7EA")
    static let LegendDarkColor:Color = Color(hexString: "#545454")
    static let IndicatorKnob:Color = Color(hexString: "#FF57A6")
    static let GradientUpperBlue:Color = Color(hexString: "#C2E8FF")
    static let GradientUpperBlue1:Color = Color(hexString: "#A8E1FF")
    static let GradientPurple:Color = Color(hexString: "#7B75FF")
    static let GradientNeonBlue:Color = Color(hexString: "#6FEAFF")
    static let GradientLowerBlue:Color = Color(hexString: "#F1F9FF")
    static let DarkPurple:Color = Color(hexString: "#1B205E")
    static let BorderBlue:Color = Color(hexString: "#4EBCFF")
}

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

enum GradientColors {
    static let orange = GradientColor(start: Colors.OrangeStart, end: Colors.OrangeEnd)
    static let blue = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    static let green = GradientColor(start: Color(hexString: "0BCDF7"), end: Color(hexString: "A2FEAE"))
    static let blu = GradientColor(start: Color(hexString: "0591FF"), end: Color(hexString: "29D9FE"))
    static let bluPurpl = GradientColor(start: Color(hexString: "4ABBFB"), end: Color(hexString: "8C00FF"))
    static let purple = GradientColor(start: Color(hexString: "741DF4"), end: Color(hexString: "C501B0"))
    static let prplPink = GradientColor(start: Color(hexString: "BC05AF"), end: Color(hexString: "FF1378"))
    static let prplNeon = GradientColor(start: Color(hexString: "FE019A"), end: Color(hexString: "FE0BF4"))
    static let orngPink = GradientColor(start: Color(hexString: "FF8E2D"), end: Color(hexString: "FF4E7A"))
}

public struct Styles {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleOrangeLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleOrangeDark = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.white,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleNeonBlueLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleNeonBlueDark = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: Color.white,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartMidnightGreenDark = ChartStyle(
        backgroundColor: Color(hexString: "#36534D"), //3B5147, 313D34
        accentColor: Color(hexString: "#FFD603"),
        secondGradientColor: Color(hexString: "#FFCA04"),
        textColor: Color.white,
        legendTextColor: Color(hexString: "#D2E5E1"),
        dropShadowColor: Color.gray)
    
    public static let barChartMidnightGreenLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color(hexString: "#84A094"), //84A094 , 698378
        secondGradientColor: Color(hexString: "#50675D"),
        textColor: Color.black,
        legendTextColor:Color.gray,
        dropShadowColor: Color.gray)
    
    public static let pieChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeEnd,
        secondGradientColor: Colors.OrangeStart,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let lineViewDarkMode = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.white,
        legendTextColor: Color.white,
        dropShadowColor: Color.gray)
}
