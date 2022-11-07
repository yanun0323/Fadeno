//
//  Dao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/27.
//

import Foundation
import CoreData
import UIComponent

final class Dao: UsertaskDao, UserSettingDao, ClickupDao {
    internal var delegateUD: UsertaskDaoDelegate
    internal var ctx: NSManagedObjectContext
    internal var request: NSFetchRequest<UsertaskMO>
    
    init() {
        self.delegateUD = UsertaskDaoDelegate()
        self.ctx = PersistenceController.context
        self.request = .init(entityName: "UsertaskMO")
    }
}

extension Dao: Repository {}
