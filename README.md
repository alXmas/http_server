# HTTP Server
### Задание 1
Написать web-сервер, который:
По GET-запросу `/counter` возвращает значение целочисленной глобальной переменной `counter`.
По POST-запросу `/counter` увеличивает значение переменной `counter` на число, переданное в теле запроса. В ответе передать json `{'message':'success'} `с корректным заголовком `Content-Type`.
По GET-запросам возвращает файлы из указанной директории (директорию выбрать самостоятельно) по соответствующим путям. Например для директории `/home/www` и пути запроса `/index.html` вернуть файл `/home/www/index.html`.
Для возвращаемых файлов корректно устанавливать заголовок `Content-Type` в зависимости от типа файла.
Если по указанному пути файл не найден и запрос не принадлежит пунктам 1 и 2, возвращать ответ `NOT FOUND` со статусом `404`.
### Задание 2
Написать proxy-сервер, который
Будет передавать все запросы на web-сервер из задания 1.
Для GET-запроса `/style.css` будет подменять ответ на содержимое файла `malware.css` (файл будет предоставлен при проверке задания).
### Задание 3
Написать proxy-сервер, который
Будет передавать все запросы на web-сервер из задания 1.
Для всех запрашиваемых html-файлов в теге `<head>` будет добавлять тег `<script type='text/javascript'>` с содержимым файла `malware.js` (файл будет предоставлен при проверке задания).
Примечание
Для выполнения заданий следует использовать примитивы уровня TCP предоставляемые выбранным языком программирования.
Использовать примитивы уровня HTTP запрещено!
### Запуск
```
ruby bin/server.rb
```
### Пример использования
Откроем `telnet` на `3000` порту и напишем GET запрос: 
```cassandraql

GET /counter HTTP/1.0
host: localhost

HTTP/1.0 200 OK
Content-Type: text/plain
Referrer-Policy: no-referrer
Content-Length: 1
Date:Thu, 07 Mar 2019 11:35:38 GMT
Connection: close

0
Connection closed by foreign host.
```
Напишем POST запрос:
```cassandraql
POST /counter HTTP/1.0
host: localhost
7

HTTP/1.0 200 OK
Content-Type: application/json
Referrer-Policy: no-referrer
Content-Length: 23
Date:Thu, 07 Mar 2019 11:39:14 GMT
Connection: close

["message:", "success"]
Connection closed by foreign host.

```