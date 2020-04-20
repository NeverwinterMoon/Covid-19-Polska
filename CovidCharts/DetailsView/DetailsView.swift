//
//  DetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                VerticalSpacer()
                TitleView(title: "Szczegóły", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Images.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Images.reload) {
                    self.showDetailsView.toggle()
                }
                VerticalSpacer()
                VerticalSpacer()
                List {
                    Text("Dupa")
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                    Spacer()
                }
                .background(Colors.customViewBackground)
            }
        }

    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(showDetailsView: .constant(true)).environmentObject(ChartViewModel())
    }
}


struct DismissButtonView: View {
    var body: some View {
        Image(systemName: Images.dismiss)
            .font(.system(size: 30, weight: .bold))
            .frame(width: 40, height: 40)
            .foregroundColor(Color(UIColor.systemGray5))
    }
}
