# README

To run the app just use clone the repository and run the following command 

docker-compose up

* Ruby version : 2.6.8
* Rails version : 5.2.6

* APIs
    * Application
      * Create: POST hostname:3000/applications 
        * body should include property "name"
      * Update: PUT/PATCH hostname:3000/applications/:token
        * body should include property name to be updated
      * Delete: DELETE hostname:3000/applications/:token
      * Get: GET hostname:3000/applications or hostname:3000/applications/:token
    * Chats
        * Create: POST hostname:3000/chats
          * body should include property "token"
        * Update: PUT/PATCH hostname:3000/chats/:number
          * No updateable fields so far, created just in case
        * Delete: DELETE hostname:3000/chats/:number
          * body should include property "token"
        * Get: GET hostname:3000/chats or hostname:3000/chats/:number
          * body should include property "token"
    * Messages
      * Create: POST hostname:3000/messages
        * body should include properties "chat_id", "token" and "data"
      * Update: PUT/PATCH hostname:3000/applications/:number
        * body should include properties "chat_id", "token" and "data"
      * Delete: DELETE hostname:3000/applications/:number
        * body should include properties "chat_id" and "token" 
      * Get: GET hostname:3000/:number or hostname:3000/messages/:number
        * body should include properties "chat_id" and "token"
      * Serch: GET hostname:3000/search
        * body should include properties "chat_id", "token" and "query"