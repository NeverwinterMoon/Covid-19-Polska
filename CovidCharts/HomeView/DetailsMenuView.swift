//
//  DetailsMenuView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 24/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DetailsMenuView: View {

    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsMenuView: Bool
    @State var showPolandDetails: Bool = false
    @State var showProvinceDetails: Bool = false
    
    var body: some View {
            
        VStack {
            Spacer()
            VStack {
//                Rectangle()
//                    .frame(width: 40, height: 5)
//                    .cornerRadius(3)
//                    .opacity(0.1)
//                    .padding(.top,16)
                    Text("Wybierz opcję")
                        .font(Fonts.popupTitle)
                        .foregroundColor(Colors.label)
                        .padding(.bottom, 8)
                        .padding(.top, 12)
                        .animation(nil)
                    Spacer()
                        .frame(width: UIScreen.width - 32, height: 1, alignment: .center)
                        .background(Colors.label)
                        .padding(.bottom, 4)
                    HStack (alignment: .center, spacing: 16) {
                        Spacer()
                        Button(action: {
                            self.showPolandDetails.toggle()
                        }) {
                            VStack {
                                IconView(name: Icons.table, size: .large, weight: .semibold, color: Colors.main)
                                Text("Tabela zakażeń")
                                    .font(Fonts.indicatorTitle)
                                    .foregroundColor(Colors.label)
                                .frame(width: 160)
                            }
                            .sheet(isPresented: $showPolandDetails)  {
                                PolandStatsView(showView: self.$showPolandDetails).environmentObject(self.vm)
                            }
                        .frame(width: 160)
                            .padding(.vertical, 8)
                            .background(Colors.customViewBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
                        }
                        .padding(.vertical, 8)
                        Spacer()
                        Button(action: {
                            print("Show województwa tapped")
                            self.showProvinceDetails.toggle()
                        }) {
                            VStack {
                                IconView(name: Icons.bars, size: .large, weight: .semibold, color: Colors.main)
                                Text("Województwa")
                                    .font(Fonts.indicatorTitle)
                                    .foregroundColor(Colors.label)
                                .frame(width: 160)
                            }.sheet(isPresented: self.$showProvinceDetails) {
                                ProvincesStatsView(showView: self.$showProvinceDetails).environmentObject(self.vm)
                                
                            }
                                .frame(width: 160)
                            .padding(.vertical, 8)
                            .background(Colors.customViewBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
                        }
                        .padding(.vertical, 8)
                        Spacer()
                        
                    }
                Button(action: {
                    self.showDetailsMenuView.toggle()
                }) {
                    Text("Zamknij")
                        .font(Fonts.popupTitle)
                        .padding(.vertical, 8)
                        .foregroundColor(Colors.main)
                }
                Spacer()
                }
            .frame(width: UIScreen.width, height: 180, alignment: .center)
            .background(Colors.background)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        }
    }
}

struct DetailsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsMenuView(showDetailsMenuView: .constant(false)).environmentObject(ChartViewModel())
    }
}
