//
//  InfoPopupView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 19/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct InfoPopupView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var title: String
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Text(title)
                    .font(Fonts.titlePopup)
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(Fonts.text)
                Button(action: {
                    self.vm.showPopup.toggle()
                }) {
                    Text("OK")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(width: UIScreen.width-64, height: 50, alignment: .center)
                        .font(Fonts.titleButton)
                }
                .frame(width: UIScreen.width/2 + 68, height: 50, alignment: .center)
                .background(Colors.main)
                .cornerRadius(16)
            }
            .padding()
            .frame(width: UIScreen.width/2 + 100, alignment: .center)
            .background(Colors.customViewBackground)
            .cornerRadius(30)
            .shadow(radius: 20)
            Spacer()
        }

    }
}

struct InfoPopupView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPopupView(title: "Example title", message: "Message asdasd asd asd asd asd asd asd asd asd asd asd asd asd asd asd ").environmentObject(ChartViewModel())
    }
}
