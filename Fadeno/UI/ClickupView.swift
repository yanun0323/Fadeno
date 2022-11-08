//
//  ClickupView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/31.
//

import SwiftUI
import UIComponent

struct ClickupView: View {
    @EnvironmentObject var container: DIContainer
    var body: some View {
        VStack(spacing: 0) {
            ClickupTasklistView()
        }
    }
}

struct ClickupVIew_Previews: PreviewProvider {
    static var previews: some View {
        ClickupView()
            .inject(DIContainer.preview)
    }
}
