# to do task DB Schema

###### 更新日期：2019-01-30 (規劃 DB Schema 與 Model 之間的關聯)

## Task

| Field      | Type     | Description  |
|------------|----------|--------------|
| title      | string   | 標題         |
| content    | text     | 內容         |
| due_date   | date     | 結束時間      |
| status     | integer  | 狀態         |
| priority   | integer  | 優先順序      |
| user_id    | integer  | 使用者        |

## Category

| Field      | Type     | Description  |
|------------|----------|--------------|
| name       | string   | 種類        |

## Category of Task

| Field      | Type     | Description  |
|------------|----------|--------------|
| category_id| integer  | 種類         |
| task_id    | integer  | 任務         |

## User

| Field    | Type     | Description  |
|----------|----------|--------------|
| name     | string   | 姓名         |
| email    | string   | 電子信箱      |
| password | string   | 密碼         |
