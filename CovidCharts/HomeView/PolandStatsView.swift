//
//  PolandStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 24/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct PolandStatsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showView: Bool
    
    var body: some View {
        ZStack {
            Colors.customViewBackground
            VStack {
                HStack {
                    Button(action: {
                        self.showView.toggle()
                    }) {
                        IconView(name: Icons.hide, size: .large, weight: .medium, color: Colors.label)
                    }
                    .padding(.leading, 12)
                    .padding(.top, 16)
                    Spacer()
                }
                Text("COVID-19 w Polsce")
                    .font(Fonts.indicatorTitle)
                    .foregroundColor(Colors.label)
                    .padding(.vertical, 8)
                Spacer()
                    .frame(width: UIScreen.width - 32, height: 1, alignment: .center)
                    .background(Colors.label)
                List {
                    Section(header: TableHeader()) {
                        HStack {
                            ParameterColumn(parameter: .date)
                            ParameterColumn(parameter: .confirmed).environmentObject(self.vm)
                            ParameterColumn(parameter: .confirmedInc).environmentObject(self.vm)
                            ParameterColumn(parameter: .deaths).environmentObject(self.vm)
                            ParameterColumn(parameter: .deathsInc).environmentObject(self.vm)
                            ParameterColumn(parameter: .recovered).environmentObject(self.vm)
                            ParameterColumn(parameter: .recoveredInc).environmentObject(self.vm)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .background(Colors.customViewBackground)
            }.background(Colors.customViewBackground)
        }
    }
    
}

struct PolandStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PolandStatsView(showView: .constant(true)).environmentObject(ChartViewModel())
    }
}


fileprivate struct TableHeader: View {
    var body: some View {
        HStack {
            HStack {
                Spacer()
                IconView(name: Icons.calendar, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.confirmed, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.increase, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.deaths, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.increase, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.recovered, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
            HStack {
                Spacer()
                IconView(name: Icons.increase, size: .medium, weight: .semibold, color: Colors.main)
                Spacer()
            }
        }.padding(.vertical, 8)
            .background(Colors.customViewBackground)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
