//
//  ChartToolbarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartToolbar: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    @Binding var showPopup: Bool
    


    var body: some View {
        VStack {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
            HStack {
                ChartToolbarLeftSide(showPopup: $showPopup)
                Spacer()
                ShowDetailsButton(detailsViewModel: DetailsViewModel(data: vm.getData(vm.parameter), parameter: vm.parameter), showDetailsView: $showDetailsView)
            }
            .frame(width: UIScreen.width + 32, height: 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
        }

    }
    
}

struct ChartToolbar_Previews: PreviewProvider {
    static var previews: some View {
        ChartToolbar(showDetailsView: .constant(false), showPopup: .constant(false)).environmentObject(ChartViewModel())
    }
}

private struct ShowDetailsButton: View {
    
    var detailsViewModel: DetailsViewModel
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    
    var body: some View {
        Button(action: {
            self.showDetailsView.toggle()
        }) {
            Text("Pokaż szczegóły")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .multilineTextAlignment(.leading)
                .foregroundColor(Colors.label)
                .padding(.trailing, 16)
        }.sheet(isPresented: $showDetailsView) {
            DetailsView(vm: self.detailsViewModel, showDetailsView: self.$showDetailsView)
            
        }
        .frame(width: 170, height: 40, alignment: .center)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}
