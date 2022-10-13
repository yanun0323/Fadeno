import Foundation

extension DIContainer {
    static var preview: DIContainer {
        DIContainer(appState: AppState.preview, interactor: Interactor.preview)
    }
}

extension AppState {
    static var preview: AppState {
        AppState(shared: SharedState(page: 0, tasks: [
            UserTask.preview.urgent,
            UserTask.preview.normal,
            UserTask.preview.todo,
            UserTask.preview.archive,
        ]))
    }
}

extension Interactor {
    static var preview: Interactor {
        Interactor(global: GlobalInteractor(appState: AppState.preview))
    }
}

extension UserTask {
    static var preview = UserTask.Preview()
    
    class Preview {
        let urgent = UserTask(0, "測試緊急標題", "測試緊急概要", """
        ## 測試緊急內容
        - List A
            - inline list
            - inline list
        - List B
        
        **Emp**
        *Hey*
                
        |This|Is|Table|Header|
        |:---:|:---:|:---:|:---:|
        |A|B|C|D|
        
        ```go
        func Hello() int {
            return 0
        }
        ```
        
        ```swift
        func Hello() -> Int {
            0
        }
        ```
        """, false, .urgent)
        let normal = UserTask(0, "測試進行標題", "測試進行概要", "## 測試進行內容", false, .normal)
        let todo = UserTask(0, "測試代辦標題", "測試代辦概要", """
        ## 測試代辦內容
        - List A
            - inline list
            - inline list
        - List B
        
        **Emp**
        *Hey*
                
        |This|Is|Table|Header|
        |:---:|:---:|:---:|:---:|
        |A|B|C|D|
        
        ```go
        func Hello() int {
            return 0
        }
        ```
        
        ```swift
        func Hello() -> Int {
            0
        }
        ```
        """, false, .todo)
        let archive = UserTask(0, "測試封存標題", "測試封存概要", "## 測試封存內容", false, .archive)
    }
}
