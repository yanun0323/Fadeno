//
//  DeleteBlock.swift
//  Fadeno
//
//  Created by Yanun on 2022/10/29.
//

import SwiftUI
import UIComponent

struct DeleteBlock: View {
    @EnvironmentObject var container: DIContainer
    @State var taskToDelete: Usertask
    @Binding var deleting: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("delete")
                .font(.title3)
            Text("' \(taskToDelete.title) '")
                .font(.title3)
            
            HStack(spacing:30) {
                ButtonCustom(width: 100, height: 30, color: .red.opacity(0.8), radius: 5, shadow: 1) {
                    withAnimation {
                        container.interactor.usertask.DeleteUsertask(taskToDelete)
                        deleting = false
                    }
                } content: {
                    Text("Delete")
                        .foregroundColor(.white)
                }
                
                ButtonCustom(width: 100, height: 30, color: .section, radius: 5, shadow: 1) {
                    withAnimation {
                        deleting = false
                    }
                } content: {
                    Text("Cancel")
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct DeleteBlock_Previews: PreviewProvider {
    static var previews: some View {
        DeleteBlock(taskToDelete: .init(), deleting: .constant(false))
            .inject(DIContainer.preview)
    }
}
