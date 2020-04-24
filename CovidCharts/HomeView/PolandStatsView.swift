//
//  PolandStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 24/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct PolandStatsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showView: Bool
    
    var body: some View {

                ScrollView {
                        CovidTableView()
                            .padding(.vertical)
                }.onDisappear {
                    self.showView.toggle()
        }
    }
    
}

struct PolandStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PolandStatsView(showView: .constant(true)).environmentObject(ChartViewModel())
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}
