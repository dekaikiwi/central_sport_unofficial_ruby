# Central Sports API (Unofficial)

This is an unofficial Ruby wrapper for the Central Sports API. I have no affiliation with Central Sports and there is no guarantee that this API will be supported going forward. This was just a project to build an API wrapper for fun!

With that being said feel free to fork, make PRs, etc as you please :)

Central Sports is a Gym Franchise in Japan.

## Installation

```
gem install central_sports
```

## Usage

```
require 'central_sports'

client = CentralSports::Client.new

# Get the schedule for this club
schedule = client.schedule_for_club(145)

# Get all the Zumba classes on the schedule.
zumba_classes = schedule.zumba_classes
```

## Tests

```
rake test
```

## Rake Tasks

```
rake console
```

Load the gem directly into IRB for debugging/testing in the terminal

```
rake update_clubs
```

Update the list of clubs in lib/data/clubs.yml

```
rake translate_club_names
```

Manually set English names for clubs that don't have an email translation yet.
