##Usage
**Регистрация:**

 

    curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/my/users.json -d '{"user": {"username": "username", "password": "password"}}'

**Авторизация:**

    curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/my/users/sign_in.json
    -d '{"user": {"username": "username", "password": "password"}}'

**Создание чата:**

    curl -X POST http://localhost:3000/chats.json -d "chat[name]=Chat10&chat[user_ids][]=1&chat[user_ids][]=2"

**Получение списка чатов:**

    curl -X GET http://localhost:3000/chats.json

**Получение списка пользователей:**

    curl -X GET http://localhost:3000/users.json

