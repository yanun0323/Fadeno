import Foundation

extension DIContainer {
    static var preview: DIContainer {
        DIContainer(isMock: true)
    }
}

extension AppState {
    static var preview: AppState {
        AppState()
    }
}

extension Usertask {
    static var preview = Usertask.Preview()
    
    class Preview {
        let urgent = Usertask(0, "Urgent 測試緊急標題0", "測試緊急概要", """
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
        let urgent1 = Usertask(1, "Urgent 測試緊急標題1", "測試緊急概要 https://www.google.com", """
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
        let normal = Usertask(0, "Normal 測試進行標題", "https://www.google.com", "## 測試進行內容", false, .normal)
        let todo = Usertask(0, "Todo 測試代辦標題", "測試代辦概要", """
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
        let archive = Usertask(0, "Archive 測試封存標題", "測試封存概要", "", false, .archived)
    }
}

extension Clickup.Task {
    
    static var preview: Clickup.Task? {
        guard let data = json.data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(Clickup.Task.self, from: data)
        } catch {
            print("parse preview clickup task failed")
            return nil
        }
    }
    
    static private var json: String {
        """
        {
              "id": "3rw88ne",
              "custom_id": null,
              "name": "[BELS] Phase2 wireframe",
              "text_content": null,
              "description": null,
              "status": {
                "status": "todo",
                "color": "#d3d3d3",
                "type": "open",
                "orderindex": 0
              },
              "orderindex": "33742770.00000000000000000000000000000000",
              "date_created": "1667446966525",
              "date_updated": "1667446983032",
              "date_closed": null,
              "archived": false,
              "creator": {
                "id": 5912640,
                "username": "Bobo Zhan",
                "color": "#3e2724",
                "email": "bobo@bitoex.com",
                "profilePicture": "https://attachments.clickup.com/profilePictures/5912640_x35.jpg"
              },
              "assignees": [
                {
                  "id": 5912640,
                  "username": "Bobo Zhan",
                  "color": "#3e2724",
                  "initials": "BZ",
                  "email": "bobo@bitoex.com",
                  "profilePicture": "https://attachments.clickup.com/profilePictures/5912640_x35.jpg"
                },
                {
                  "id": 5912640,
                  "username": "Bobo Zhan",
                  "color": "#44ee33",
                  "initials": "BZ",
                  "email": "bobo@bitoex.com",
                  "profilePicture": "https://attachments.clickup.com/profilePictures/5912640_x35.jpg"
                },
                {
                  "id": 5912640,
                  "username": "Bobo Zhan",
                  "color": "#3e2724",
                  "initials": "BZ",
                  "email": "bobo@bitoex.com",
                  "profilePicture": "https://attachments.clickup.com/profilePictures/5912640_x35.jpg"
                }
              ],
              "watchers": [],
              "checklists": [],
              "tags": [
                {
                  "name": "pmqa",
                  "tag_fg": "#0DBC37",
                  "tag_bg": "#0DBC37",
                  "creator": 5903691
                },
                {
                  "name": "hotfix",
                  "tag_fg": "#E50000",
                  "tag_bg": "#E50000",
                  "creator": 5753984
                }
              ],
              "parent": null,
              "priority": {
                "id": "2",
                "priority": "high",
                "color": "#ffcc00",
                "orderindex": "2"
              },
              "due_date": "1667505600000",
              "start_date": null,
              "points": null,
              "time_estimate": null,
              "custom_fields": [
                {
                  "id": "7949b532-32f2-4d40-a5e4-72e49abf0a57",
                  "name": "PM 期望完成日",
                  "type": "date",
                  "type_config": {},
                  "date_created": "1667179026731",
                  "hide_from_guests": false,
                  "required": false
                },
                {
                  "id": "3fc4446c-a166-4708-a7cb-b8ad71f5e76e",
                  "name": "Issue Date",
                  "type": "date",
                  "type_config": {},
                  "date_created": "1658053570344",
                  "hide_from_guests": false,
                  "required": false
                },
                {
                  "id": "13390897-7a78-4114-8a75-9bbde5c5b52d",
                  "name": "工作量",
                  "type": "drop_down",
                  "type_config": {
                    "default": 0,
                    "placeholder": null,
                    "options": [
                      {
                        "id": "5d39dff6-5559-4c1c-b216-0a0057dd4a99",
                        "name": "微量 (0.5hr 內)",
                        "color": null,
                        "orderindex": 0
                      },
                      {
                        "id": "2b053df0-3b36-4c0e-b62c-ca5eacfc74fe",
                        "name": "一般 (2hr 內)",
                        "color": null,
                        "orderindex": 1
                      },
                      {
                        "id": "998ddf5e-2b4f-43ef-afca-132863d995b5",
                        "name": "需要一點時間 (4hr)",
                        "color": null,
                        "orderindex": 2
                      },
                      {
                        "id": "23a0e5a4-4ad6-460c-90a2-0637108c6e42",
                        "name": "需要很多時間 (8hr)",
                        "color": null,
                        "orderindex": 3
                      },
                      {
                        "id": "46bbd1f1-5d58-48e2-9576-28788b0f620d",
                        "name": "詳見細項 (超過 8hr)",
                        "color": null,
                        "orderindex": 4
                      }
                    ]
                  },
                  "date_created": "1665953837716",
                  "hide_from_guests": false,
                  "value": 3,
                  "required": false
                },
                {
                  "id": "3c08deba-3ffd-43fd-88be-6da1a7d17797",
                  "name": "Progress",
                  "type": "automatic_progress",
                  "type_config": {
                    "tracking": {
                      "subtasks": true
                    },
                    "complete_on": 3,
                    "subtask_rollup": false
                  },
                  "date_created": "1663868351452",
                  "hide_from_guests": false,
                  "value": {
                    "percent_complete": 0
                  },
                  "required": false
                }
              ],
              "dependencies": [],
              "linked_tasks": [],
              "team_id": "3780765",
              "url": "https://app.clickup.com/t/3rw88ne",
              "permission_level": "create",
              "list": {
                "id": "380970258",
                "name": "Sprint 16 (10/31 - 11/6)",
                "access": true
              },
              "project": {
                "id": "97583018",
                "name": "PM's Sprint",
                "hidden": false,
                "access": true
              },
              "folder": {
                "id": "97583018",
                "name": "PM's Sprint",
                "hidden": false,
                "access": true
              },
              "space": {
                "id": "5932135"
              }
            }
        """
    }
}
