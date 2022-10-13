import CoreGraphics
import SwiftUI

struct Config {
    static let Popover = PopoverSetting()
    static let Windows = WindowsSetting()
    static let Task = TaskSetting()
    static let Animation = AnimationSet()
}

struct PopoverSetting {
    let MinWidth: CGFloat = 100
    let MaxWidth: CGFloat = 500
}

struct WindowsSetting {
    let MinWidth: CGFloat = 350
    let MaxWidth: CGFloat = 500
    let MinHeight: CGFloat = 600
    let MaxHeight: CGFloat = 1000
}

struct TaskSetting {
    let Emergency = TaskSettingUnit(Title: String(localized: "Urgent"), Color: .red)
    let Processing = TaskSettingUnit(Title: String(localized: "Normal"), Color: .accentColor)
    let Todo = TaskSettingUnit(Title: String(localized: "Todo"), Color: .gray)
    let Block = TaskSettingUnit(Title: String(localized: "Block"), Color: .yellow)
}

struct TaskSettingUnit {
    let Title: String
    let Color: Color
}

struct AnimationSet {
    static private let duration: Double = 0.2
    let Default = Animation.easeInOut(duration: duration)
    let EaseIn = Animation.easeIn(duration: duration)
    let EaseOut = Animation.easeOut(duration: duration)
    
}


struct Previews_Config_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow_Previews.previews
    }
}
