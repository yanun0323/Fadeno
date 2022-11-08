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
        guard let data = taskJson1.data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(Clickup.Task.self, from: data)
        } catch {
            print("parse preview clickup task failed")
            return Clickup.NewErrorTask("preview1", error)
        }
    }
    
    static var preview2: Clickup.Task? {
        guard let data = taskJson2.data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(Clickup.Task.self, from: data)
        } catch {
            print("parse preview clickup task failed")
            return Clickup.NewErrorTask("preview2", error)
        }
    }
    
    static private var taskJson1: String {
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
    static private var taskJson2: String {
        """
        {
          "id": "3qtufv4",
          "custom_id": "PRO-18879",
          "name": "[Pro][測試票] 測試 Click up API 用",
          "text_content": "這是測試的票HEHEHEHEHEHEHE HEHEHEHEHEHE  HEHEHE",
          "description": "這是測試的票HEHEHEHEHEHEHE HEHEHEHEHEHE  HEHEHE",
          "status": {
            "id": "sc29022859_71K7C1mh",
            "status": "todo",
            "color": "#d3d3d3",
            "orderindex": 0,
            "type": "open"
          },
          "orderindex": "33740772.00000000000000000000000000000000",
          "date_created": "1666680357889",
          "date_updated": "1667900367779",
          "date_closed": null,
          "archived": false,
          "creator": {
            "id": 37777540,
            "username": "Yanun",
            "color": "#ff5251",
            "email": "yanunyang@psp-power.com.tw",
            "profilePicture": null
          },
          "assignees": [
            {
              "id": 37777540,
              "username": "Yanun",
              "color": "#ff5251",
              "initials": "Y",
              "email": "yanunyang@psp-power.com.tw",
              "profilePicture": null
            }
          ],
          "watchers": [
            {
              "id": 5748445,
              "username": "Ron Hsieh",
              "color": "#7b68ee",
              "initials": "RH",
              "email": "ron@bitoex.com",
              "profilePicture": "https://attachments.clickup.com/profilePictures/5748445_rJt.jpg"
            },
            {
              "id": 5753987,
              "username": "Kevin",
              "color": "#08c7e0",
              "initials": "K",
              "email": "kevin.chen@bitoex.com",
              "profilePicture": "https://attachments.clickup.com/profilePictures/5753987_Fvk.jpg"
            },
            {
              "id": 37777540,
              "username": "Yanun",
              "color": "#ff5251",
              "initials": "Y",
              "email": "yanunyang@psp-power.com.tw",
              "profilePicture": null
            }
          ],
          "checklists": [],
          "tags": [],
          "parent": null,
          "priority": null,
          "due_date": null,
          "start_date": null,
          "points": null,
          "time_estimate": null,
          "time_spent": 0,
          "custom_fields": [
            {
              "id": "30c8f74e-5a31-4e54-955b-1767ecb3c025",
              "name": "Feature Type",
              "type": "drop_down",
              "type_config": {
                "new_drop_down": true,
                "options": [
                  {
                    "id": "372458a6-2d4a-49dd-a228-100ece39864b",
                    "name": "範本",
                    "color": "#AF7E2E",
                    "orderindex": 0
                  },
                  {
                    "id": "46f2c308-1b40-471c-9b82-35b1d71f57c4",
                    "name": "特殊急件",
                    "color": "#e50000",
                    "orderindex": 1
                  },
                  {
                    "id": "fb3f982b-4621-47fc-b7f2-0eeb4f58fec4",
                    "name": "BUG",
                    "color": "#800000",
                    "orderindex": 2
                  },
                  {
                    "id": "4e85c422-60b5-4e5e-b332-adab91ee915b",
                    "name": "與規格不符",
                    "color": "#3397dd",
                    "orderindex": 3
                  },
                  {
                    "id": "b4d4f34d-ab88-478d-92ab-b2e8abbcece1",
                    "name": "交易/收發/錢包",
                    "color": "#FF4081",
                    "orderindex": 4
                  },
                  {
                    "id": "fbaa5f24-35f4-49e8-8f9d-88bb276672a3",
                    "name": "註冊/登入/驗證",
                    "color": "#E65100",
                    "orderindex": 5
                  },
                  {
                    "id": "75c307fc-3643-4e99-9e3a-38f75f7d5135",
                    "name": "會計/帳務",
                    "color": "#ff7800",
                    "orderindex": 6
                  },
                  {
                    "id": "4ee9ac32-388a-4502-b0fc-fc551681b839",
                    "name": "後台新功能",
                    "color": "#f9d900",
                    "orderindex": 7
                  },
                  {
                    "id": "fecca407-ad07-445d-afdd-e211b9955337",
                    "name": "後台功能優化",
                    "color": "#f9d900",
                    "orderindex": 8
                  },
                  {
                    "id": "e76ebb86-bafa-4ca2-b058-22f75087e959",
                    "name": "API",
                    "color": "#2ecd6f",
                    "orderindex": 9
                  },
                  {
                    "id": "f99a9c16-c133-42b7-80b7-25f935a57d0e",
                    "name": "資安/風控/防詐",
                    "color": "#2ecd6f",
                    "orderindex": 10
                  },
                  {
                    "id": "04149dc4-0d82-44a0-9ed7-e0467af6658d",
                    "name": "白帽處理",
                    "color": "#2ecd6f",
                    "orderindex": 11
                  },
                  {
                    "id": "330fff6b-a07c-44a4-84ef-1850d4886e2b",
                    "name": "報表需求",
                    "color": "#81B1FF",
                    "orderindex": 12
                  },
                  {
                    "id": "c7183749-575e-48e0-8481-e1dfb6a70ae6",
                    "name": "文案優化",
                    "color": "#fff",
                    "orderindex": 13
                  },
                  {
                    "id": "6db90448-dba0-4188-a2b0-cbd909baf38f",
                    "name": "體驗/跑版",
                    "color": null,
                    "orderindex": 14
                  },
                  {
                    "id": "1aed7fc9-8409-4596-af7d-e60ef0747e08",
                    "name": "迭代優化",
                    "color": null,
                    "orderindex": 15
                  },
                  {
                    "id": "0a634bf4-3d2b-42ae-a06f-5b032077f7aa",
                    "name": "規則/防呆",
                    "color": null,
                    "orderindex": 16
                  },
                  {
                    "id": "ae4e59bb-f7a8-4771-8290-ca4684f7cd8e",
                    "name": "系統穩定",
                    "color": null,
                    "orderindex": 17
                  },
                  {
                    "id": "9b6038c1-5f94-4adf-90c5-8e0f976befbe",
                    "name": "程式重構",
                    "color": null,
                    "orderindex": 18
                  },
                  {
                    "id": "670c722d-6995-48ca-bb99-797d3ddd12c9",
                    "name": "主流程",
                    "color": "#fff",
                    "orderindex": 19
                  },
                  {
                    "id": "ddfcc22f-07c6-4617-9845-0ff3994b78df",
                    "name": "新功能",
                    "color": null,
                    "orderindex": 20
                  },
                  {
                    "id": "a8137da2-b8fd-4c8a-b254-5faab193bac7",
                    "name": "SUPPORT",
                    "color": "#fff",
                    "orderindex": 21
                  },
                  {
                    "id": "f0df5797-48c9-401f-88d1-7478e823ea02",
                    "name": "其他",
                    "color": "#fff",
                    "orderindex": 22
                  }
                ]
              },
              "date_created": "1608274814889",
              "hide_from_guests": false,
              "required": false
            },
            {
              "id": "587eade0-08b9-4ecf-b18f-cb6068215f43",
              "name": "需求部門",
              "type": "drop_down",
              "type_config": {
                "new_drop_down": true,
                "options": [
                  {
                    "id": "17873ab6-620d-48f1-89ec-80685ca34a29",
                    "name": "客服",
                    "color": "#f9d900",
                    "orderindex": 0
                  },
                  {
                    "id": "bee55d18-9ac4-4c6e-9a2d-2f37797b0d26",
                    "name": "產品",
                    "color": "#04A9F4",
                    "orderindex": 1
                  },
                  {
                    "id": "679160b3-f297-4abe-9cef-95cf4f608bf1",
                    "name": "創新研究室",
                    "color": "#2ecd6f",
                    "orderindex": 2
                  },
                  {
                    "id": "a94ca3be-99f3-439f-940a-3072e6deac89",
                    "name": "研發",
                    "color": "#0231E8",
                    "orderindex": 3
                  },
                  {
                    "id": "ec827620-52f2-4dfb-9dfc-d2509b9172cb",
                    "name": "維運/DBA",
                    "color": "#3082B7",
                    "orderindex": 4
                  },
                  {
                    "id": "167016aa-b5b2-446e-8e1f-ce379223ba56",
                    "name": "QA",
                    "color": "#FF7FAB",
                    "orderindex": 5
                  },
                  {
                    "id": "1154eda8-8c74-454b-9d4b-815cf29bbc1a",
                    "name": "行銷",
                    "color": "#f900ea",
                    "orderindex": 6
                  },
                  {
                    "id": "2d49b4c9-1c10-4a1f-b05d-31f5d60f4e71",
                    "name": "財務",
                    "color": "#FF4081",
                    "orderindex": 7
                  },
                  {
                    "id": "0f1bb2ad-286c-44a1-b6fb-118ca8bf7dc3",
                    "name": "商務",
                    "color": "#EA80FC",
                    "orderindex": 8
                  },
                  {
                    "id": "1e8af4d7-d08e-40b2-8cb7-c33b0d83b428",
                    "name": "法遵",
                    "color": "#bf55ec",
                    "orderindex": 9
                  },
                  {
                    "id": "4cf7450e-9046-43b2-8e39-60557bb99ff7",
                    "name": "交易室",
                    "color": "#f9d900",
                    "orderindex": 10
                  },
                  {
                    "id": "08ad52eb-b4e5-4468-8f24-55bb714c53f4",
                    "name": "HR",
                    "color": "#2ecd6f",
                    "orderindex": 11
                  },
                  {
                    "id": "c4179489-f5ca-4337-b57e-1b6bcb6758bf",
                    "name": "法人戶",
                    "color": "#b5bcc2",
                    "orderindex": 12
                  }
                ]
              },
              "date_created": "1662984993397",
              "hide_from_guests": false,
              "required": false
            }
          ],
          "dependencies": [],
          "linked_tasks": [],
          "team_id": "3780765",
          "url": "https://app.clickup.com/t/3qtufv4",
          "permission_level": "create",
          "list": {
            "id": "29022859",
            "name": "Development",
            "access": true
          },
          "project": {
            "id": "8064474",
            "name": "Backend",
            "hidden": false,
            "access": true
          },
          "folder": {
            "id": "8064474",
            "name": "Backend",
            "hidden": false,
            "access": true
          },
          "space": {
            "id": "5732530"
          },
          "attachments": []
        }
        """
    }
}
