# Fishub Rails API

Rails backend API for the Fishub front-end application.

## Setup

1. Install the dependencies:

   ~~~sh
   bundle install
   ~~~

2. Migrate the database:

   ~~~sh
   rails db:migrate
   ~~~

3. Seed the sample data:

   ~~~sh
   rails db:seed
   ~~~

4. Fire up the server:

   ~~~sh
   bin/rails server
   ~~~

## API Endpoints

### List Baits

~~~sh
GET /baits
~~~

Example Response:

~~~text
Status: 200 OK
~~~

~~~json
[
  {
    "id": 1,
    "name": "Fat Rap",
    "category": "Crankbait",
    "image_url": "http://localhost:3000/assets/fat-rap.png"
  },
  {
    "id": 2,
    "name": "Yummy Gummy",
    "category": "Softbait",
    "image_url": "http://localhost:3000/assets/yummy-gummy.png"
  }
]
~~~

### Sign Up

Create a user:

~~~sh
POST /users
~~~

Example Request Body:

~~~json
{
  "username": "angler",
  "password": "supersecret"
}
~~~

Example Response:

~~~text
Status: 201 Created
~~~

~~~json
{ "username": "angler" }
~~~

### Sign In

Create a session:

~~~sh
POST /session
~~~

Example Request Body:

~~~json
{
  "username": "angler",
  "password": "supersecret"
}
~~~

Example Response:

~~~sh
Status: 200 OK
~~~

~~~json
{ "username": "angler" }
~~~

### Create a Tackle Box Item

Requires authentication.

~~~sh
POST /tackle-box-items
~~~

Example Request Body:

~~~json
{
  "bait_id": "1"
}
~~~

Example Response:

~~~sh
Status: 201 Created
~~~

~~~json
{
  "id": 1,
  "bait": {
    "id": 1,
    "name": "Fat Rap",
    "category": "Crankbait",
    "image_url": "http://localhost:3000/assets/fat-rap.png"
  }
}
~~~

### List All Tackle Box Items

Requires authentication.

~~~sh
GET /tackle-box-items
~~~

Example Response:

~~~sh
Status: 200 OK
~~~

~~~json
[
  {
    "id": 1,
    "bait": {
      "id": 1,
      "name": "Fat Rap",
      "category": "Crankbait",
      "image_url": "http://localhost:3000/assets/fat-rap.png"
    }
  }
]
~~~

### Create a Catch

Requires authentication.

~~~sh
POST /baits/1/catches
~~~

Example Request Body:

~~~json
{
  "species": "Walleye",
  "weight": 3.25,
  "length": 18.5
}
~~~

Example Response:

~~~sh
Status: 201 Created
~~~

~~~json
{
  "id": 4,
  "species": "Walleye",
  "weight": "3.25",
  "length": "18.5",
  "created_at": "2018-11-01 23:07:54 UTC"
}
~~~

### List All Catches On a Bait

Requires authentication.

~~~sh
GET /baits/1/catches
~~~

Example Response:

~~~sh
Status: 200 OK
~~~

~~~json
[
  {
    "id": 4,
    "species": "Walleye",
    "weight": "3.25",
    "length": "18.5",
    "created_at": "2018-11-01 23:07:54 UTC"
  }
]
~~~

### List Activity

~~~sh
GET /activity
~~~

Example Response:

~~~sh
Status: 200 OK
~~~

~~~json
[
  {
    "id": 1,
    "species": "Lake Trout",
    "weight": "3.0",
    "length": "21.5",
    "created_at": "2018-09-24 23:07:54 UTC",
    "bait": "Fat Rap",
    "bait_image_url": "http://localhost:3000/assets/fat-rap.png",
    "username": "nicole"
  },
  {
    "id": 2,
    "species": "Brown Trout",
    "weight": "2.0",
    "length": "18.0",
    "created_at": "2018-10-07 23:06:35 UTC",
    "bait": "Yummy Gummy",
    "bait_image_url": "http://localhost:3000/assets/yummy-gummy.png",
    "username": "mike"
  }
]
~~~

### Errors and Status Codes

Attempting to authenticate with invalid credentials returns `401 Unauthorized`:

~~~text
HTTP/1.1 401 Unauthorized
~~~

~~~json
{
  "error": "Invalid credentials"
}
~~~

Attempting to access a protected resource without being signed in returns `401 Unauthorized`:

~~~text
HTTP/1.1 401 Unauthorized
~~~

~~~json
{
  "error": "Requires authentication"
}
~~~

Requests that don't include a valid CSRF token return `401 Unauthorized`:

~~~text
HTTP/1.1 401 Unauthorized
~~~

~~~json
{
  "error": "Invalid token"
}
~~~

If a request fails any validations, `422 Unprocessable Entity` is returned with errors in the following format:

~~~text
HTTP/1.1 422 Unprocessable Entity
~~~

~~~json
{
  "errors": {
    "weight": [
      "must be greater than 0"
    ],
    "length": [
      "must be greater than 0"
    ]
  }
}
~~~

When a requested resource can't be found, `404 Not Found` is returned:

~~~text
HTTP/1.1 404 Not Found
~~~

~~~json
{
  "error": "Not Found"
}
~~~