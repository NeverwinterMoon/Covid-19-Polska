//
//  BarHorizontalChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 22/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct BarHorizontalDataEntity: Hashable {
    var title: String
    var value1: Double
    var value2: Double?
}

public class BarHorizontalData: ObservableObject, Identifiable {
    
    @Published var data: [BarHorizontalDataEntity]

    var ID = UUID()
    
    init(data: [BarHorizontalDataEntity]) {
        self.data = data
    }

}

struct BarHorizontalChartView: View {
    
    @ObservedObject var vm: BarHorizontalData
    
    var title: String
    var legend1: String
    var color1: Color
    var legend2: String?
    var color2: Color?
    var barHeight: CGFloat
    
    @State var showValues: Bool = false
    
    var max: Double {
        return vm.data.max { (region1, region2) -> Bool in
            return region2.value1 > region1.value1
        }?.value1 ?? 0
    }
    
    init(title: String = "Title", data: [BarHorizontalDataEntity], legend1: String = "legend2", color1: Color = Color.red, legend2: String = "legend2", color2: Color? = nil, barHeight: CGFloat = 8.0) {
        self.title = title
        self.vm = BarHorizontalData(data: data)
        self.legend1 = legend1
        self.legend2 = legend2
        self.color1 = color1
        self.color2 = color2
        self.barHeight = barHeight
    }
    
    var body: some View {
        ZStack {
            Colors.customViewBackground
            
            VStack (alignment: .leading, spacing: 0) {
                BarTopView(title: title)
                HStack {
                    Spacer()
                    VStack (alignment: .center, spacing: 0) {
                        Spacer()
                    }
                    .padding(.all)
                    .frame(width: UIScreen.width - 32, height: 1)
                    .background(Colors.label)
                    Spacer()
                }
                
                ChartLegendView(color1: color1, title1: legend1, color2: color2, title2: legend2)
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: 100)
                        HStack {
                            XIndicator(value: 0)
                            Spacer()
                            XIndicator(value: Int(max/4))
                            .foregroundColor(Colors.label)
                            .font(Fonts.listElementDetails)
                            Spacer()
                            XIndicator(value: Int(max*(3/4)))
                            .foregroundColor(Colors.label)
                            .font(Fonts.listElementDetails)
                            Spacer()
                            XIndicator(value: Int(max))
                            .foregroundColor(Colors.label)
                            .font(Fonts.listElementDetails)
                        }
                    .frame(width: CGFloat((UIScreen.width - 142)), height: 1, alignment: .center)
                        
                    }
                    HStack {
                        Spacer()
                            .frame(width: 100)
                        Spacer()
                            .frame(width: CGFloat((UIScreen.width - 142)), height: 1, alignment: .center)
                            .background(Colors.label)
                    }
                }.padding(.top, 8)
                HStack {
                    Spacer()
                    .frame(width: 100)
                    Spacer()
                        .frame(width: 1, height: 4, alignment: .center)
                        .background(Colors.label)
                }
                ForEach(vm.data, id: \.self) { entity in
                        HStack {
                            Text(entity.title)
                            .foregroundColor(Colors.label)
                            .font(Fonts.listElement)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80, alignment: .trailing)
                            .lineLimit(nil)
                            .padding(.trailing, 8)
                            .padding(.leading, 8)
                            Spacer()
                                .frame(width: 1, height: 30, alignment: .center)
                                .background(Colors.label)
                                .padding(.leading, 4)
                            VStack (alignment: .leading) {
                                HStack {
                                    Spacer()
                                        .frame(width: self.setWidth(entity.value1), height: self.barHeight, alignment: .leading)
                                        .background(self.color1)
                                    Text(self.showValues ? "\(Int(entity.value1))" : "")
                                        .padding(.leading, 2)
                                    .font(Fonts.listElementDetails)
                                    .foregroundColor(Colors.label)
                                }
                                if entity.value2 != nil {
                                    HStack {
                                        Spacer()
                                            .frame(width: self.setWidth(entity.value2 ?? 0), height: self.barHeight, alignment: .leading)
                                            .background(self.color2)
                                        Text(self.showValues ? "\(Int(entity.value2 ?? 0))" : "")
                                            .padding(.leading, 2)
                                        .font(Fonts.listElementDetails)
                                        .foregroundColor(Colors.label)
                                    }
                    
                                }
                            }
                            Spacer()
                        }
                        .onLongPressGesture(minimumDuration: 1000, maximumDistance: 4, pressing: { (isPressing) in
                            if isPressing {
                                self.showValues.toggle()
                            } else {
                                self.showValues.toggle()
                            }
                        }) {}
                        .frame(width: UIScreen.width)
                }
            }
            .padding(.vertical, 16)
            .background(Colors.customViewBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                        .background(Colors.customViewBackground)

        }
    }
    
    func setWidth(_ value: Double) -> CGFloat {
        let width = CGFloat(value/self.max)
        return CGFloat((UIScreen.width - 142)) * width
    }
    
}

struct BarHorizontalChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarHorizontalChartView(data: [BarHorizontalDataEntity(title: "Dolnośląskie", value1: 100, value2: 40), BarHorizontalDataEntity(title: "Warmińsko-Mazurskie", value1: 40, value2: 10)], color2: Color.blue)
    }
}

fileprivate struct BarTopView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .padding(.bottom, 8)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Colors.label)
                .frame(width: 250)
            Spacer()
        }
    }
}

struct ChartLegendView: View {
    
    var color1: Color
    var title1: String
    
    var color2: Color?
    var title2: String?
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
                .frame(width: 25, height: 6)
                .background(color1)
            Text(title1)
                .font(Fonts.listElement)
                .multilineTextAlignment(.trailing)
                .padding(.all, 8)
            if title2 != nil {
                Spacer()
                    .frame(width: 25, height: 6)
                    .background(color2)
                Text(title2 ?? "")
                    .font(Fonts.listElement)
                    .multilineTextAlignment(.trailing)
                    .padding(.all, 8)
            }
            Spacer()
        }
    }
}

struct XIndicator: View {
    
    var value: Int
    
    var body: some View {
        Text("\(value)")
            .foregroundColor(Colors.label)
            .font(Fonts.listElementDetails)
    }
}
