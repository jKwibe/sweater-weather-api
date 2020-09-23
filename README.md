# README

## Description

It is a the back-end of a mock Road-Trip Application. It consumes the [OpenWeather API](https://openweathermap.org/api/one-call-api) and the [MapQuest API](https://developer.mapquest.com/documentation/geocoding-api/) and exposes the data consumed in an API that the front-end of this application would use. This API also handles user registration, login, and authentication and authorization. 

## Getting Started

#### Requirements:

- Ruby 2.5.3
- PostgreSQL 12.1
- Redis

#### Installation:

```
$ git clone https://github.com/jKwibe/sweater-weather-api.git
$ cd sweater-weather-api
$ gem install bundler   
$ bundle   
$ rails db:{drop,create,migrate,seed}   
$ bundle exec figaro install   
```

If you have problems bundling, try deleting `Gemfile.lock`

## Environment Setup:

##### You will need the following:

MAPQUEST: [MapQuest](https://developer.mapquest.com/documentation/geocoding-api/)

UNSPLASH: [Unspalsh Developer](https://unsplash.com/developers)

OPENWEATHER: [OpenWeather Key](https://openweathermap.org/api/one-call-api)

Add the following environment variables to your `config/application.yml` file. Insert the relevant values in place of 'insert_here'.  

```
WEATHER_API: 'insert_here'   
MAP_API: 'insert_here'   
UNSPLASH_API_ID: 'insert_here'   
JSON_WEB_TOKEN_SECRET: 'insert_here'   
```

## Tests

To run the test suite, run the following command: `bundle exec rspec`. You must be connected to the internet and your environment variables must be set up correctly for the `/spec/services` tests to pass. The same applies for running the app in development.

## Development

To run Ghost Diary in development, execute the following commands from the project directory (you will need three separate tabs):

```
$ redis-server
$ rails s
```

Visit `http://localhost:3000` to view the application in development.

## Tools

#### Notable Gems:

* Faraday
* Figaro
* Jwt
* Travis

#### Testing:

* SimpleCov
* RSpec
* Shoulda-matchers
* Factory bot

Continuous Integration with Travis-CI

### Endpoints

GET Background

`{{URL}}/api/v1/background?location=pueblo,co`

request:

```json
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "credit_to": "John D0e",
            "image_url": "https://images.unsplash.com/photo-1591647932208-aef7c24886c0?ixlib=rb-1.2.1&i"
        }
    }
}
```



GET Forecast

`{{URL}}/api/v1/forecast?location=denver,co`

request:

```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "city": "Denver",
            "state": "CO",
            "country": "US",
            "current": {
                "time": "10:36 am,  Sep 23",
                "sunrise": " 6:48 am",
                "sunset": " 6:55 pm",
                "temp": 72.73,
                "feels_like": 65.39,
                "humidity": 27,
                "icon": "http://openweathermap.org/img/wn/04d.png",
                "uvi": 7.24,
                "visibility": 10000,
                "weather_description": "broken clouds"
            },
            "hourly": [
                {
                    "time": "12 am",
                    "temp": 72.91,
                    "icon": "http://openweathermap.org/img/wn/04n.png"
                },
                {
                    "time": " 1 am",
                    "temp": 71.67,
                    "icon": "http://openweathermap.org/img/wn/01n.png"
                },
                ...
            ],
            "daily": [
                {
                    "time": "Wednesday",
                    "temp_high": 82.83,
                    "temp_low": 68.22,
                    "precipitation": null,
                    "description": "Clouds"
                },
                {
                    "time": "Thursday",
                    "temp_high": 88.07,
                    "temp_low": 67.3,
                    "precipitation": null,
                    "description": "Clouds"
                }
                ...
            ]
        }
    }
}
```

POST SIGNUP

`{{URL}}/api/v1/sign-up`

body:

```json
{
    "email": "test@turing.com",
    "password": < password >,
    "password_confirmation": < password >
}
```

response:

`status: 200`

```json
{
    "data": {
        "id": "5",
        "type": "user",
        "attributes": {
            "email": "test@turing.com",
            "access_token": < token >
        }
    }
}
```

`status: 400`

```json
{
    "data": {
        "id": null,
        "type": "error",
        "attributes": {
            "message": < error message >
        }
    }
}
```

POST LOGIN

`{{URL}}/api/v1/session`

body: 

Logs a user into a session, authenticating using their password. Response will also retrieve user's unique API key

```json
{
    "email":"< email >,
    "password": < password >
}
```



response:

`status: 200`

```json
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "test21@test.com",
            "access_token": "token"
        }
    }
}
```

`status: 400`

```json
{
    "data": {
        "id": null,
        "type": "error",
        "attributes": {
            "message": "error message"
        }
    }
}
```



POST ROAD TRIP

`{{URL}}/api/v1/road_trip`

body:

```json
{
    "origin": "Pueblo,CO",
    "destination":"Denver,CO",
    "access_token": "token"
}
```

response:

`status: 200`

```json
{
    "data": {
        "id": null,
        "type": "trip",
        "attributes": {
            "origin": "Denver,CO",
            "destination": "Pueblo,CO",
            "destination_temperature": 81.73,
            "destination_weather_desc": "scattered clouds",
            "time_taken": 6373
        }
    }
}
```

`status: 401 and 400`

```json
{
    "data": {
        "id": null,
        "type": "error",
        "attributes": {
            "message": "error message"
        }
    }
}
```



## Contributor


* [Kwibe Merci](https://github.com/jKwibe)

## Acknowledgments

* [Ian Douglas](https://github.com/iandouglas)
* [Dione Wilson](https://github.com/dionew1)
