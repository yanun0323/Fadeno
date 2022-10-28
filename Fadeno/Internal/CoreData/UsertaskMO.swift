//
//  UsertaskMO.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/27.
//

import Foundation

extension UsertaskMO {
    func New() -> Usertask {
        Usertask.init(self)
    }
    
    func Update(from t: Usertask) {
        self.id = t.id
        self.title = t.title
        self.order = Int32(t.order)
        self.outline = t.outline
        self.content = t.content
        self.type = Int32(t.type.rawValue)
        self.complete = t.complete
        self.updateTime = t.updateTime
    }
}
