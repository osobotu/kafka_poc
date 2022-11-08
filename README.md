# Flutter, KafkaJs and Kakfa Integration

The goal of this project is to integrate a Flutter App with Kafka.

## Architecture

On a high level, the project consists of three main components, a Flutter app, a websocket server and kafka.

The Flutter app subscribes to a websocket server build using socket.io. The websocket server acts as a consumer to a Kafka broker and emits changes received from the Kafka broker.

## Installation

Firstly, you must have the following installed.

1. [Flutter](https://docs.flutter.dev/get-started/install)
2. [NodeJs](https://nodejs.org/en/download/)
3. [Docker](https://docs.docker.com/get-docker/)

To run the project:

- Open a terminal,
