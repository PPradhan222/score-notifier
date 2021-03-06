# Score Notifier
> Score Notifier is an app built on Ruby on Rails that allow users to select expected scores of live matches on which they want to get notified, And send them push notification accordingly.

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Screencast demo](#screencast)
* [Features](#features)
* [Setup](#setup)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)


## General Information
- On any busy day, a user might not be able to watch the complete cricket match live, but also does not wants to miss great moments of matches like players approaching 100s, hattricks or they just want to watch any particular player batting after he crossed some 'x' runs or played some 'y' balls.
- This is what this app is intended to solve by allowing users to select expected future milestone moments of the matches, on only which they want to get notified.
- The user will get a push notification on his device whenever the match or any player reaches the milestone moment selected by that particular user.


## Screencast

https://user-images.githubusercontent.com/46857985/121814860-dc669780-cc90-11eb-9698-69ede8622a2d.mp4




## Technologies Used
- Rails 6.0.3.5
- [kimurai gem](https://github.com/vifreefly/kimuraframework) for web scrapping
- [webpush gem](https://github.com/zaru/webpush) for sending push message from rails server
- [sidekiq cron](https://github.com/ondrejbartas/sidekiq-cron) to schedule scores & matches update and push notification.
- redis for websocket and job queues.
- Bootstrap 4, javascript, html & css for frontend.
- For more information on the gems and dependencies used, please refer to the gemfile.


## Features
- shows recent, live and upcoming matches.
- users can select future milestone moments (can be runs a player scored, balls he faced, number of fours or sixes he smashed, and even his strike rate) to get notifications on them.
- the system sends push notifications to the users according to the users' selected milestone moments.


## Setup
To be Added soon....


## Project Status
Project is in_progress.


## Room for Improvement

Room for improvement:
- Currently, the recently added milestone moments of any live matches for notifications are stored on the database, which gets destroyed as soon as the notification for it is sent.  And accessing moments from the database frequently increases the latency. So, I think it would be better to store the moments on the Redis.

- Currently, the data related to matches including live scores is scrapped from an online cricket score application, which makes the system unreliable and slow. So, I think it would be better to have a reliable 3rd party API for the scores.

- As of now, live scores are displayed in real time through websocket(which is a bidirectional connection), but in displaying live scores we do not need an open connection from the client side, and the current websocket took a lot of tcp acks which is not required. So, I am thinking to replace websockets with server sent events(in which only the server will send the real time data) to display live scores.

To do:
- Add condition to allow one active milestone moment per player in a match.
- Store milestone moments of matches in Redis instead of the database.
- Make it a progressive web app.
