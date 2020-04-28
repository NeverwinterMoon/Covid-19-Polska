//
//  ContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showPopup: Bool
    @State var showDetailsMenuView: Bool = false
    @State var chartBottom: CGFloat = 0
    @State var chartTitle: String = "Zakażenia"
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                if !vm.dailyData.isEmpty {
                    HomeTitleView(title: "\(vm.highlightedData.date.formattedDate(.long))")
                    Spacer()
                    HStack (spacing: 6) {
                        Spacer()
                        VStack (spacing: 12)  {
                            Spacer()
                            StatisticsView(icon: Icons.up, titles: ["Zakażenia:", "Zgony:", "Wyleczeni:"], values: [vm.highlightedData.confirmedInc, vm.highlightedData.deathsInc, vm.highlightedData.recoveredInc])
                            StatisticsView(icon: Icons.sum, titles: ["Zakażenia:", "Zgony:", "Wyleczeni:"], values: [vm.highlightedData.confirmed, vm.highlightedData.deaths, vm.highlightedData.recovered])
                            Spacer()
                        }
                        VStack {
                            Text(self.vm.highlightedData.date.formattedDate(.day))
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                                .foregroundColor(Colors.chartTop)
                                .padding(.horizontal, 16)
                            Text(self.vm.highlightedData.date.formattedDate(.month))
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .padding(.horizontal, 16)
                            Text(self.vm.highlightedData.date.formattedDate(.year))
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                            .padding(.horizontal, 18)
                        }
                        .frame(height: 157, alignment: .center)
                        .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 16, bl: 16, br: 16))
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        HStack {
                            Button(action: {
                                print("Calendar")
                            }) {
                                IconView(name: Icons.calendar, size: .medium, weight: .semibold, color: Colors.chartTop)
                            }
                            
                        }
                        .frame(width: 50, height: 40, alignment: .center)
                        .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                        Text(chartTitle)
                        .font(.system(size: 32, weight: .semibold, design: .default))
                            .padding(.leading, 8)
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Action1")
                            }) {
                                IconView(name: Icons.confirmed, size: .medium, weight: .semibold, color: Colors.chartTop)
                            }
                            Button(action: {
                                print("Action1")
                            }) {
                                IconView(name: Icons.deaths, size: .medium, weight: .semibold, color: Colors.chartTop)
                            }
                            Button(action: {
                                print("Action1")
                            }) {
                                IconView(name: Icons.recovered, size: .medium, weight: .semibold, color: Colors.chartTop)
                            }
                            .padding(.trailing, 8)
                        }
                        .frame(width: 130, height: 40, alignment: .center)
                            .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 0, bl: 16, br: 0))
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                    }
                    ChartView(data: vm.getData(vm.parameter), title: vm.chartTitle, minX: vm.minDate, maxX: vm.maxDate)
                        
                }
                else {
                    VStack (spacing: 40) {
                        ActivityIndicator()
                            .frame(width: 60, height: 60, alignment: .center)
                        Text("Ładowanie danych...")
                            .font(Fonts.popupTitle)
                            .foregroundColor(Colors.main)
                    }
                    .foregroundColor(Colors.main)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .blur(radius: self.vm.showPopup ? 10 : 0)
            .blur(radius: self.showDetailsMenuView ? 10 : 0)
            InfoPopupView(title: vm.popup.title, message: vm.popup.text)
                .scaleEffect(self.vm.showPopup ? 1.0 : 0.5)
                .opacity(self.vm.showPopup ? 1.0 : 0.0)
                .animation(.spring())
            GeometryReader { (geometry) in
                DetailsMenuView(showDetailsMenuView: self.$showDetailsMenuView)
                    .offset(x: 0, y: self.showDetailsMenuView ? 0 : geometry.size.height)
                    .animation(.spring())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showPopup: .constant(false)).environmentObject(ChartViewModel())
    }
}

struct ActivityIndicator: View {

  @State private var isAnimating: Bool = false

  var body: some View {

    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<5) { index in
        Group {
          Circle()
            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
            .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
            .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
        }.frame(width: geometry.size.width, height: geometry.size.height)
            .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
            .animation(Animation
                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                .repeatForever(autoreverses: false))
        }
    }.aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating.toggle()
    }
    .onDisappear {
        self.isAnimating.toggle()
    }
    }
    
}

struct StatisticsView: View {

    var icon: String
    var titles: [String]
    var values: [Int]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(titles[0] + " \(values[0])")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
                HStack {
                    Text(titles[1] + " \(values[1])")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
                HStack {
                    Text(titles[2] + " \(values[2])")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
            }
            .frame(width: 200, height: 65, alignment: .center)
                .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                .offset(x: 80)
            IconView(name: icon, size: .large, weight: .semibold, color: Colors.customViewBackground)
            .frame(width: 80, height: 80, alignment: .center)
            .background(Colors.chartTop)
            .clipShape(Circle())
            .shadow(color: Colors.chartTop.opacity(0.7), radius: 8, x: -4, y: 8)
        }.offset(x: -90)
    }
}

//struct HomeTopBar: View {
//
//    @EnvironmentObject var vm: ChartViewModel
//
//    var body: some View {
//        HStack {
//            Button(action: {
//                self.vm.setPopup(title: "Kalendarz", text: "Funkcja dostępna wkrótce")
//                self.vm.showPopup.toggle()
//            }) {
//                IconView(name: Icons.calendar, size: .medium, weight: .regular, color: Colors.label)
//            }
//            Button(action: {
//                self.vm.setPopup(title: "Kalendarz", text: "Funkcja dostępna wkrótce")
//                self.vm.showPopup.toggle()
//            }) {
//                IconView(name: Icons.more, size: .medium, weight: .regular, color: Colors.label)
//            }
//            Spacer()
//            Button(action: {
//                self.vm.showPopup.toggle()
//            }) {
//                IconView(name: Icons.info, size: .medium, weight: .regular, color: Colors.label)
//
//
//            }
//
//        }.padding(.horizontal, 16)
//       //     .background(Color.yellow)
//    }
//}

struct HomeTitleView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var title: String
    
    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    self.vm.setPopup(title: "Menu", text: "Menu")
                    self.vm.showPopup.toggle()
                }) {
                    IconView(name: Icons.menu, size: .medium, weight: .regular, color: Colors.chartTop)
                }
                .padding(.trailing, 8)
            }
            .frame(width: 50, height: 40, alignment: .trailing)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            
            HStack {
                Text("Statystyki")
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(Colors.label)
                Text("Covid-19 Polska")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Colors.chartTop)
                    .offset(x: -30, y: 20)
            }
            .padding(.horizontal, 8)
            Spacer()
            HStack {
                Button(action: {
                    self.vm.setPopup(title: "Źródło danych", text: "Wykresy tworzone na podstawie danych publikowanych przez Ministerstwo Zdrowia/WHO")
                    self.vm.showPopup.toggle()
                }) {
                    IconView(name: Icons.info, size: .medium, weight: .regular, color: Colors.chartTop)
                }
                .padding(.leading, 8)
                Spacer()
            }
            .frame(width: 50, height: 40, alignment: .leading)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 0, bl: 16, br: 0))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            
        }.padding(.top, 16)
    }
}

//struct ParametersView: View {
//
//    @EnvironmentObject var vm: ChartViewModel
//
//    var body: some View {
//        HStack {
//            Spacer()
//            VStack (alignment: .leading, spacing: 2) {
//                Spacer()
//                Text("Zakażenia")
//                    .font(.system(size: 16, weight: .bold, design: .default))
//                    .foregroundColor(Colors.label)
//                ChartDetailsElement(icon: Icons.confirmed, number: self.vm.highlightedData.confirmed)
//                ChartDetailsElement(icon: Icons.increase, number: self.vm.highlightedData.confirmedInc)
//                Spacer()
//                Text("Zgony")
//                    .font(.system(size: 16, weight: .bold, design: .default))
//                    .foregroundColor(Color(UIColor.label))
//                ChartDetailsElement(icon: Icons.deaths, number: self.vm.highlightedData.deaths)
//                ChartDetailsElement(icon: Icons.increase, number: self.vm.highlightedData.deathsInc)
//                Spacer()
//            }
//            Spacer()
//            VStack (alignment: .leading, spacing: 2) {
//                Spacer()
//                Text("Wyzdrowienia")
//                    .font(.system(size: 16, weight: .bold, design: .default))
//                    .foregroundColor(Color(UIColor.label))
//                ChartDetailsElement(icon: Icons.recovered, number: self.vm.highlightedData.recovered)
//                ChartDetailsElement(icon: Icons.increase, number: self.vm.highlightedData.recoveredInc)
//                Spacer()
//                Text("Wykres")
//                    .font(.system(size: 16, weight: .bold, design: .default))
//                    .foregroundColor(Color(UIColor.label))
//                ChartDetailsElement(icon: Icons.deaths, number: self.vm.highlightedData.deaths)
//                ChartDetailsElement(icon: Icons.increase, number: self.vm.highlightedData.deathsInc)
//                Spacer()
//            }
//            Spacer()
//        }
//    }
//}
