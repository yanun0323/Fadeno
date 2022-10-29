//
//  Dao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/27.
//

import Foundation
import CoreData

final class Dao: UsertaskDao, UserSettingDao {
    internal var delegateUD: UsertaskDaoDelegate
    internal var ctx: NSManagedObjectContext
    internal var request: NSFetchRequest<UsertaskMO>
    
    init() {
        self.delegateUD = UsertaskDaoDelegate()
        self.ctx = PersistenceController.shared.container.viewContext
        self.request = .init(entityName: "UsertaskMO")
    }
}

extension Dao: Repository {}
