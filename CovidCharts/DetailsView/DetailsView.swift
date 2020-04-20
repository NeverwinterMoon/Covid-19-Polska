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
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.red)
            Spacer()
        }
        .onAppear {
            print("Showed details")
            print(self.vm.data)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(vm: DetailsViewModel(data: [], parameter: .confirmed), showDetailsView: .constant(true))
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
