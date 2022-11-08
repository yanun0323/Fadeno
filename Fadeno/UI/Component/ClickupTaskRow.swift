//
//  ClickupTaskView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/3.
//

import SwiftUI
import UIComponent

struct ClickupTaskRow: View {
    @State private var isHover = false
    @State var task: Clickup.Task
    var body: some View {
        HStack {
            Text(task.status.status.uppercased())
                .fontWeight(.light)
                .foregroundColor(.white)
                .padding(.horizontal)
                .frame(width: 150, height: 25)
                .background(Color.init(hex: task.status.color))
                .cornerRadius(5)
            Text(task.name ?? "")
                .font(.title3)
                .padding(.horizontal)
                .frame(height: 25, alignment: .leading)
            Spacer()
            TagBlock
                .frame(width: 170, alignment: .leading)
            Text(task.priority?.priority?.uppercased() ?? "-")
                .foregroundColor(.white)
                .padding(.horizontal)
                .frame(width: 100, height: 20)
                .background(Color.init(hex: task.priority?.color))
                .clipShape(Capsule())
            AssigneesBlock
                .frame(width: 120)
        }
        .padding(5)
        .background()
        .colorMultiply(isHover ? .init(hex: "#ddd") : .white)
        .onHover { value in
            isHover = value
        }
        
    }
}

// MARK: - View Block
extension ClickupTaskRow {
    var TagBlock: some View {
        HStack(spacing: 5) {
            ForEach(0 ..< 3) { i in
                if task.tags.count > i {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 20)
                        Text(task.tags[i].name)
                            .foregroundColor(.init(hex: task.tags[i].tagFg))
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .frame(width: 50, height: 20)
                            .background(Color.init(hex: task.tags[i].tagBg).opacity(0.15))
                            .lineLimit(1)
                    }
                }
            }
        }
    }
    
    var AssigneesBlock: some View {
        HStack(spacing: -7) {
            ForEach(0 ..< 5) { i in
                if task.assignees.count > i {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.init(hex: task.assignees[i].color))
                        Text(task.assignees[i].username?.first?.uppercased() ?? "-")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                    .frame(width: 28, height: 28)
                    .background()
                    .clipShape(Circle())
                    .zIndex(Tool.IntToDouble(10-i))
                }
            }
        }
    }
}

// MARK: - Function
extension ClickupTaskRow {}

struct ClickupTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        ClickupTaskRow(task: .preview!)
            .frame(width: 1200)
    }
}

