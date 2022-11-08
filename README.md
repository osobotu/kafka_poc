# Flutter, KafkaJs and Kakfa Integration

The goal of this project is to integrate a Flutter App with Kafka.

## Architecture

On a high level, the project consists of three main components; a Flutter app, a websocket server and Kafka.

The Flutter app subscribes to a websocket server built using socket.io. The websocket server acts as a consumer to a Kafka broker and emits changes received from the Kafka broker.

## Installation

Firstly, you must have the following installed.

1. [Flutter](https://docs.flutter.dev/get-started/install)
2. [NodeJs](https://nodejs.org/en/download/)
3. [Docker](https://docs.docker.com/get-docker/)

To run the project:

- Open a terminal and enter `./start.sh` to run the start up script.
- Open another terminal and enter `node producer.js`. This runs a Kafka producer that writes a string to the `kafka-poc` topic in the running Kafka Broker.
- Open yet another terminal (LOL 😜), run `cd client/flutter_kafkajs && flutter run`

You should have a Flutter app running like so 👇🏾.

![Running app GIF](https://github.com/osobotu/kafka_poc/Simulator-Screen-Recording-iPhone-14-Pro-Max-2022-11-08-at-14.09.30.gif)
