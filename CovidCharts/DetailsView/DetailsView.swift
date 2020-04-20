//
//  DetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var details: DetailsViewModel
    
    @Binding var showDetailsView: Bool
//    @State var showPopup: Bool = false
//    @State var bottomState: CGSize = .zero
//    @State var showFull: Bool = false
    
    var body: some View {
        List {
//            Colors.appBackground
//                .edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                
                Button(action: {
                    self.showDetailsView.toggle()
                }) {
                    DismissButtonView()
                }
                .padding([.trailing, .top], 8)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            VStack (spacing: 0) {
                
                ToolbarView()
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.red)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(showDetailsView: .constant(true)).environmentObject(DetailsViewModel())
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
