# to do task DB Schema

###### 更新日期：2019-02-08 (規劃 DB Schema 與 Model 之間的關聯)

## Task

| Field      | Type     | Description  |
|------------|----------|--------------|
| title      | string   | 標題         |
| content    | text     | 內容         |
| deadline   | datetime | 結束時間      |
| status     | integer  | 狀態         |
| priority   | integer  | 優先順序      |
| user_id    | bigint   | 使用者        |

## Tag

| Field      | Type     | Description  |
|------------|----------|--------------|
| name       | string   | 標籤          |

## Tags Tasks

| Field      | Type     | Description  |
|------------|----------|--------------|
| tag_id     | bigint   | 標籤         |
| task_id    | bigint   | 任務         |

## User

| Field           | Type     | Description  |
|-----------------|----------|--------------|
| name            | string   | 姓名         |
| email           | string   | 電子信箱      |
| password_digest | string   | 密碼         |
| tasks_count     | integer  | 任務數量      |
| role            | string   | 角色         |

## Deploy

1. 登入 Heroku 並建立 app
2. heroku git:remote -a app_name
3. Gemfile 刪除 rails 預設的 gem 'sqlite3'
4. hide production.rb 的 config.active_storage.service = :local (此 app 暫時用不到)
5. git push heroku master
6. heroku run rake db:migrate
