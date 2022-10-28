//
//  HomeView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/28.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .overlay {
                Text("Home")
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
