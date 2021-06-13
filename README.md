# Score Notifier
> Score Notifier is an app built on Ruby on Rails that allow users to select expected scores of live matches on which they want to get notified, And send them push notification accordingly.

## Table of Contents
* [General Info](#general-information)
* [Screencast](#screencast)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Setup](#setup)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)


## General Information
- On any busy day, a user might not be able to watch the complete cricket match live, but also does not wants to miss great moments of matches like players approaching 100s, hattricks or they just want to watch any particular player batting after he crossed some 'x' runs or played some 'y' balls.
- This is what this app is intended to solve by allowing users to select expected future milestone moments of the matches, on only which they want to get notified.
- The user will get a push notification on his device whenever the match or any player reaches the milestone moment selected by that particular user.


## Screencast
![Example screenshot](./img/screenshot.png)


## Technologies Used
- Rails 6.0.3.5
- [kimurai gem](https://github.com/vifreefly/kimuraframework) for web scrapping
- [webpush gem](https://github.com/zaru/webpush) for sending push message from rails server
- [sidekiq cron](https://github.com/ondrejbartas/sidekiq-cron) to schedule scores & matches update and push notification.
- redis for websocket and job queues.
- Bootstrap 4, javascript, html & css for frontend.
- For more gems and dependencies, please refer to the gemfile.


## Features
- shows recent, live and upcoming matches.
- users can select future milestone moments (can be runs a player scored, balls he faced, number of fours or sixes he smashed, and even his strike rate) to get notifications on them.
- the system sends push notifications to the users according to the users' selected milestone moments.


## Setup
To be Added.....


## Project Status
Project is in_progress.


## Room for Improvement

Room for improvement:
- Currently, the recently added milestone moments of any live matches for notifications are stored on the database, which gets destroyed as soon as the notification is sent for it.  And creating, reading and destroying moments to/from the database frequently increases the latency. So, I think it would be better to store the moments on an in-memory cache like Redis.

- Currently, the data related to matches including live scores is scrapped from an online cricket score application, which makes the system unreliable and slow. So, I think it would be better to have a reliable 3rd party API for the scores.

To do:
- Add condition to allow only one active milestone moment per player in a match.
- Store milestone moments of matches in Redis instead of the database.

