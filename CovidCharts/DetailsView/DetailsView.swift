//
//  DetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var vm: DetailsViewModel
    @Binding var showDetailsView: Bool
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                
                Button(action: {
                    self.showDetailsView.toggle()
                }) {
                    DismissButtonView()
                }
                .padding([.trailing, .top, .bottom], 8)
            }
        //    DetailsChartView()
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.red)
            Spacer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(vm: DetailsViewModel(), showDetailsView: .constant(true))
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

//struct DetailsChartView: View {
//
//    @EnvironmentObject var db: ChartDatabase
//    @EnvironmentObject var vm: DetailsViewModel
//
//    var body: some View {
//        VStack (alignment: .center, spacing: 0) {
//            Spacer()
//                .frame(width: UIScreen.width, height: 8, alignment: .center)
//                .background(Color.clear)
//            ChartTopView()
//            Spacer()
//                 .frame(width: UIScreen.width, height: 8, alignment: .center)
//            ChartContentView()
//                .padding(.leading, 2)
//            ChartBottomView()
//                .padding(.horizontal)
//            Spacer()
//                .frame(width: UIScreen.width, height: 8, alignment: .center)
//                .background(Color.clear)
//        }
//        .frame(width: UIScreen.width+32, height: UIScreen.height/1.75)
//        .background(Colors.customViewBackground)
//        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
//    }
//
//}
