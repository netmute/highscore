# Simple highscore backend for html5 games

This is a simple API that you can post scores to, and get highscore lists back.

## Requirements

This is the stuff you need to install prior to the installation.

* Ruby 1.9
* Sqlite 3

## Installation

Clone the repo.

    git clone https://github.com/netmute/highscore.git
    cd highscore

Then you need to install bundler, and use it to install the apps dependencies.

    gem install bundler
    bundle install

That's it. You should be ready to go.

Start the application with:

    bundle exec puma

## Usage

### Submit a new score

    POST /gamename?player=Playername&score=123

Available parameters:

* **gamename**: The name of the game this score is for. (*required*)
* **player**: The name of the player who owns this score. (*required*)
* **score**: The score as integer. (*required*)
* **scope**: If you want to scope the score, provide one here. This is useful if you want to track scores based on levels or difficulty. (*optional*)

Example:

    POST /mygame?player=simon&score=99&scope=level1
    
    Answer:
    {
      "id":4,
      "game":"mygame",
      "scope":"level1",
      "player":"simon",
      "score":99,
      "created_at":"2013-01-20T16:07:15+01:00"
    }

### Receive a highscore list

    GET /gamename

Available parameters:

* **gamename**: The name of the game to get scores for. (*required*)
* **scope**: Scope of the scores to get. (*optional*)
* **reverse**: true or false. If true, lists the smallest score first. Otherwise lists the highest score first. (*optional*, default: false)
* **limit**: Number of scores to return. (*optional*, default: 10)

Example:

    GET /mygame?scope=easy&reverse=true&limit=3
    
    Answer:
    [
      {
        "id":13,
        "game":"mygame",
        "scope":"easy",
        "player":"simon",
        "score":13,
        "created_at":"2013-01-20T15:53:22+01:00"
      },
      {
        "id":2,
        "game":"mygame",
        "scope":"easy",
        "player":"simon",
        "score":99,
        "created_at":"2013-01-20T15:53:22+01:00"
      },
      {
        "id":5,
        "game":"mygame",
        "scope":"easy",
        "player":"simon",
        "score":123,
        "created_at":"2013-01-20T15:53:22+01:00"
      }
    ]