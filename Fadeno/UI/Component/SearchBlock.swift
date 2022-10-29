//
//  SearchBlock.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/11.
//

import SwiftUI
import UIComponent

struct SearchBlock: View {
    @EnvironmentObject var container: DIContainer
    @Binding var text: String
    @State private var timer: CacheTimer?
    @State private var input: String = ""
    var body: some View {
        TextField("Search...", text: Binding(get: {
            input
        }, set: { value in
            input = value
            text = input.trimmingCharacters(in: .whitespaces)
            timer?.Refresh()
        }))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .textFieldStyle(.plain)
            .lineLimit(1)
            .background {
                Capsule()
                    .foregroundColor(.section)
                    .shadow(radius: 1.2)
            }
            .onAppear {
                if timer != nil { return }
                timer = .init(countdown: 3, timeInterval: 0.1, action: {
                    container.interactor.usertask.Publish()
                })
                timer?.Init()
            }
    }
}

struct SearchBlock_Previews: PreviewProvider {
    static var previews: some View {
        SearchBlock(text: .constant(""))
            .padding()
            .frame(width: 500, height: 500)
            .inject(DIContainer.preview)
    }
}
