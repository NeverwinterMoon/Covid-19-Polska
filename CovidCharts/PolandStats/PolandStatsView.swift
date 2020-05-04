//
//  PolandStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 01/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct PolandStatsView: View {
    
    var population = 38383000

    
    enum StatsParameter {
        case per100000, percent
    }
    
    func getValue(value: Int, param: StatsParameter) -> String {
        switch param {
        case .per100000: return String(format: "%.4f", (Double(value)/Double(38383000))*100000)
        case .percent: return String(format: "%.4f", (Double(value)/Double(38383000))*100) + "%"
        }
    }
    
    func getPercent(value1: Int, value2: Int) -> String {
        let val1 = Double(value1)
        let val2 = Double(value2)
        return String(format: "%.4f", (val1/val2)*100) + "%"
    }
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showView: Bool
    @State var showInfo: Bool = false
        
        var body: some View {
            ZStack {
                Colors.background.edgesIgnoringSafeArea(.all)
                VStack {
                    DetailsTitleBar(title: "Polska", showViewAction: {
                        self.showView.toggle()
                    }) {
                        self.showInfo.toggle()
                    }
                    ScrollView (.vertical, showsIndicators: false) {
                        SectionTitle(title: "Stan epidemii", icon: Icons.sum)
                        VStack (spacing: 16) {
                            PolandDetailsLine(title: "Liczba zakażeń łącznie", number: String(self.vm.dailyData.last?.confirmed ?? 0))
                            PolandDetailsLine(title: "Liczba zakażeń dzisiaj", number: String(self.vm.dailyData.last?.confirmedInc ?? 0))
                            PolandDetailsLine(title: "Liczba zgonów łącznie", number: String(self.vm.dailyData.last?.deaths ?? 0))
                            PolandDetailsLine(title: "Liczba zgonów dzisiaj", number: String(self.vm.dailyData.last?.deathsInc ?? 0))
                            PolandDetailsLine(title: "Liczba wyzdrowień łącznie", number: String(self.vm.dailyData.last?.recovered ?? 0))
                            PolandDetailsLine(title: "Liczba wyzdrowień dzisiaj", number: String(self.vm.dailyData.last?.recoveredInc ?? 0))
                        }
                        
                        SectionTitle(title: "Statystyki", icon: Icons.percent)
                        VStack (spacing: 16) {
                            PolandDetailsLine(title: "Liczba zakażeń na 100 tys. mieszkańców", number: getValue(value: self.vm.dailyData.last?.confirmed ?? 0, param: .per100000))
                            PolandDetailsLine(title: "Liczba zgonów na 100 tys. mieszkańców", number: getValue(value: self.vm.dailyData.last?.deaths ?? 0, param: .per100000))
                            PolandDetailsLine(title: "Zakażenia jako procent populacji", number: getValue(value: self.vm.dailyData.last?.confirmed ?? 0, param: .percent))
                            PolandDetailsLine(title: "Zgony jako procent populacji", number: getValue(value: self.vm.dailyData.last?.deaths ?? 0, param: .percent))
                            PolandDetailsLine(title: "Liczba zgonów na 100 tys. mieszkańców", number: getValue(value: self.vm.dailyData.last?.deaths ?? 0, param: .per100000))
                            PolandDetailsLine(title: "Procent przypadków śmiertelnych\nwśród zakażonych", number: getPercent(value1: self.vm.dailyData.last?.deaths ?? 0, value2: self.vm.dailyData.last?.confirmed ?? 0))
                            PolandDetailsLine(title: "Procent potwierdzonych wyzdrowień\nwśród zakażonych", number: getPercent(value1: self.vm.dailyData.last?.recovered ?? 0, value2: self.vm.dailyData.last?.confirmed ?? 0))
                        }
                        
                        // Historical data
                        SectionTitle(title: "Dane historyczne", icon: Icons.table)
                        HStack {
                            HistoryColumn(parameter: .date, icon: Icons.calendar)
                            HistoryColumn(parameter: .confirmed, icon: Icons.confirmed)
                            HistoryColumn(parameter: .confirmedInc, icon: Icons.increase)
                            HistoryColumn(parameter: .deaths, icon: Icons.deaths)
                            HistoryColumn(parameter: .deathsInc, icon: Icons.increase)
                            HistoryColumn(parameter: .recovered, icon: Icons.recovered)
                            HistoryColumn(parameter: .recoveredInc, icon: Icons.increase)
                        }
                        
                        Spacer()
                        
                    }
                    Spacer()
                }
                .blur(radius: self.showInfo ? 10 : 0)
                InfoPopupView(showView: $showInfo, title: "Źródło danych", message: "Wykresy tworzone na podstawie danych publikowanych przez Ministerstwo Zdrowia/WHO", message2: "covid19api.com\napify.com/covid-19")
                .scaleEffect(self.showInfo ? 1.0 : 0.5)
                .opacity(self.showInfo ? 1.0 : 0.0)
                .animation(.spring())
            }
        }
    }

    struct PolandStatsView_Previews: PreviewProvider {
        static var previews: some View {
            PolandStatsView(showView: .constant(true)).environmentObject(ChartViewModel())
        }
    }

struct DetailsTitleBar: View {
    
    var title: String
    var showViewAction: () -> ()
    var showInfoAction: () -> ()
    
    var body: some View {
        HStack {
            Button(action: {
                self.showViewAction()
            }) {
                IconView(name: Icons.hide, size: .medium, weight: .regular, color: Colors.chartTop)
            }
            .frame(width: 50, height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Text(title)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.label)
                .padding(.leading, 8)
            Spacer()
            Button(action: {
                self.showInfoAction()
            }) {
                IconView(name: Icons.info, size: .medium, weight: .regular, color: Colors.chartTop)
            }
            .frame(width: 50, height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 0, bl: 16, br: 0))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        }
        .padding(.top, 16)
    }
}

struct PolandDetailsLine: View {
    
    var title: String
    var number: String
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Colors.label)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 220, alignment: .center)
                Text(number)
                    .foregroundColor(Colors.chartTop)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 70, alignment: .center)
            }

        }
    }
}

struct HistoryColumn: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var parameter: ParameterType
    var icon: String
    
    var body: some View {
        VStack {
            IconView(name: icon, size: .medium, weight: .semibold, color: Colors.chartTop)
            ForEach(self.vm.loadedDailyData.reversed(), id: \.self) { day in
                DetailsText(text: self.getString(day), color: Colors.label)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }
        }
    }
    
    func getString(_ day: DailyData) -> String {
        switch parameter {
        case .confirmed: return String(day.confirmed)
        case .deaths: return String(day.deaths)
        case .recovered: return String(day.recovered)
        case .date: return String(day.date.formattedDate(.short))
        case .confirmedInc: return String(day.confirmedInc)
        case .deathsInc: return String(day.deathsInc)
        case .recoveredInc: return String(day.recoveredInc)
        }
    }
    
}
