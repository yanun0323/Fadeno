//
//  ProfileView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/28.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .overlay {
                Text("Setting View")
            }
    }
}

// MARK: ViewBlock
extension ProfileView {
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
