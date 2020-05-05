//
//  LicencesView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 04/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct LicencesView: View {
    
    @Binding var showView: Bool
    
    var body: some View {
        VStack (alignment: .center, spacing: 16) {
            LicencesTitleBar(title: "Licences & Credits") {
                self.showView.toggle()
            }
            VStack (alignment: .leading, spacing: 16) {
                SectionTitle(title: "SwiftUICharts", icon: Icons.bars)
                Text("Some significant fractions of code were used to create line charts.\n\nCopyright (c) 2019 Andras Samu\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(Colors.label)
                    .padding(.leading, 40)
                    .padding(.trailing, 32)
                SectionTitle(title: "Ikona aplikacji", icon: Icons.pencil)
                Text("Some elements of the app icon were made by Vitaly Gorbachev from www.flaticon.com")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(Colors.label)
                    .padding(.leading, 40)
                    .padding(.trailing, 32)
            }
            Spacer()
        }
    }
}

struct LicencesView_Previews: PreviewProvider {
    static var previews: some View {
        LicencesView(showView: .constant(true))
    }
}

fileprivate struct LicencesTitleBar: View {
    
    var title: String
    var showViewAction: () -> ()
    
    var body: some View {
        HStack {
            Button(action: {
                self.showViewAction()
            }) {
                IconView(name: Icons.hide, size: .medium, weight: .regular, color: Colors.main)
            }
            .frame(width: 50, height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Text(title)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.label)
                .padding(.leading, 8)
            Spacer()
        }
        .padding(.top, 16)
    }
}
