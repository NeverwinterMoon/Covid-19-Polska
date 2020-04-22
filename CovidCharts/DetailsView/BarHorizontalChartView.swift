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
    var title: String = "Chart Title"
    
    var legend1: String
    var color1: Color
    var legend2: String?
    var color2: Color?
    
    var max: Double {
        return vm.data.max { (region1, region2) -> Bool in
            return region2.value1 > region1.value1
        }?.value1 ?? 0
    }
    
    init(title: String = "Title", data: [BarHorizontalDataEntity], legend1: String = "legend2", color1: Color = Color.red, legend2: String = "legend2", color2: Color? = nil) {
        self.title = title
        self.vm = BarHorizontalData(data: data)
        self.legend1 = legend1
        self.legend2 = legend2
        self.color1 = color1
        self.color2 = color2
    }
    
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 0) {
                BarTopView(title: title)
                VStack (alignment: .center, spacing: 0) {
                    Spacer()
                }
                .padding(.all)
                .frame(width: UIScreen.width - 32, height: 1)
                .background(Colors.label)
                ChartLegendView(color1: color1, title1: legend1, color2: color2, title2: legend2)
                ForEach(vm.data, id: \.self) { entity in
                        HStack {
                            Text(entity.title)
                            .font(Fonts.titleTableElement)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80, alignment: .trailing)
                            .lineLimit(nil)
                            .padding(.trailing, 8)
                            Spacer()
                                .frame(width: 1, height: 30, alignment: .center)
                                .background(Colors.label)
                                .padding(.leading, 4)
                            VStack (alignment: .leading) {
                                Spacer()
                                    .frame(width: self.setWidth(entity.value1), height: 6, alignment: .leading)
                                    .background(self.color1)
                                if entity.value2 != nil {
                                    Spacer()
                                        .frame(width: self.setWidth(entity.value2 ?? 0), height: 6, alignment: .leading)
                                        .background(self.color2)
                                }
                            }
                            Spacer()
                        }
                        .frame(width: UIScreen.width-32)
                }
            }
            .padding(.all, 16)
        }
    }
    
    func setWidth(_ value: Double) -> CGFloat {
        let width = CGFloat(value/self.max)
                print("width: \(width)")
        return CGFloat((UIScreen.width - 134)) * width
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
                .font(Fonts.titleTableElement)
                .multilineTextAlignment(.trailing)
                .padding(.all, 8)
            if title2 != nil {
                Spacer()
                    .frame(width: 25, height: 6)
                    .background(color2)
                Text(title2 ?? "")
                    .font(Fonts.titleTableElement)
                    .multilineTextAlignment(.trailing)
                    .padding(.all, 8)
            }
            Spacer()
        }
    }
}
