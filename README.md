# Take Home Practice

## Overview
An application that handles tea subscriptions for a ficticious company

This application is completed following the mod 4 practice take-home guidelines for the Turing School of Software and Design which can be found [here](https://mod4.turing.edu/projects/take_home/take_home_be).

## Setup

This application was written in Ruby 2.7.2 with Ruby on Rails version 5.2.6.

### Local Setup
1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Set-up Figaro: `bundle exec figaro install` and add API keys (listed below) to config/application.yml
3. Setup the database: `rails db:{drop,create,migrate}`
4. Start local server to hit endpoints: `rails server`

## Endpoints
All requests should be sent with the following headers:
```
Content-Type: application/json
Accept: application/json
```

### GET /customers/:customer_id/subscriptions
Returns all of the customers subscriptions

Example Resonse:
Status: 200
```
{
    "data": [
        {
            "id": 1,
            "title": "my subscription",
            "price": 3440,
            "status": "active",
            "frequency": "weekly",
            "teas": [
                {
                    "id": 1,
                    "title": "Earl Grey",
                    "description": "black tea",
                    "temperature": 90,
                    "brew_time": 180
                },
                {
                    "id": 3,
                    "title": "Camomile",
                    "description": "herbal tea",
                    "temperature": 70,
                    "brew_time": 300
                }
            ]
        }
    ]
}
```

### POST /customers/:customer_id/subscriptions
Creates a customer subscription

Example request body:
```
{
    "frequency": "weekly",
    "title": "my subscription",
    "teas": [
        {
            "id": 1,
            "price": 520,
            "quantity": 2
        },
        {
            "id": 3,
            "price": 600,
            "quantity": 4
        }
    ]
}
```

Example response:

Status: 201
```
{
    "data": {
        "id": 1,
        "title": "my subscription",
        "price": 3440,
        "status": "active",
        "frequency": "weekly",
        "teas": [
            {
                "id": 1,
                "title": "Earl Grey",
                "description": null,
                "temperature": 90,
                "brew_time": 180
            },
            {
                "id": 3,
                "title": "Camomile",
                "description": null,
                "temperature": 70,
                "brew_time": 300
            }
        ]
    }
}
```

### DELETE /customers/:customer_id/subscriptions/:id

Deletes the subscription. Returns 204 no content on success
