//
//  SearchBlock.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/11.
//

import SwiftUI

struct SearchBlock: View {
    @State var keyWords: String = ""
    var body: some View {
        TextField("Search...", text: $keyWords)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .textFieldStyle(.plain)
            .background {
                Capsule()
                    .foregroundColor(.white)
                    .shadow(radius: 1.2)
            }
    }
}

struct SearchBlock_Previews: PreviewProvider {
    static var previews: some View {
        SearchBlock()
            .padding()
            .frame(width: 500, height: 500)
    }
}
