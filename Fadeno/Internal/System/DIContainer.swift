import Foundation

class DIContainer: ObservableObject {
    var appstate: AppState
    var interactor: Interactor
    
    init(isMock: Bool = false) {
        let appstate: AppState = isMock ? .preview : .init()
        self.appstate = appstate
        self.interactor = Interactor(isMock: isMock, appstate: appstate)
    }
}

struct Interactor {
    var usertask: UsertaskInteractor
    var tasklist: MarkdownInteractor
    var usersetting: UserSettingInteractor
    var clickup: ClickupInteractor
    
    init(isMock: Bool, appstate: AppState) {
        let dao: Repository = isMock ? DaoMock() : Dao()
        self.usertask = UsertaskInteractor(appstate: appstate, repo: dao)
        self.tasklist = MarkdownInteractor(appstate: appstate)
        self.usersetting = UserSettingInteractor(appstate: appstate, repo: dao)
        self.clickup = ClickupInteractor(appstate: appstate, repo: dao)
    }
}
