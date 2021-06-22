# セットアップ

### 3-1-backend
.env
```
MYSQL_ROOT_PASSWORD=password

TZ=Japan
```
```
docker-compose run backend rails db:seed
```
```
docker-compose up
```

### 3-1-frontend
```
yarn add nuxt
```
```
yarn dev
```
