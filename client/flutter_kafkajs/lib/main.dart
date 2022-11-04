import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(title: 'Flutter + SocketIO + KafkaJS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSocket streamSocket = StreamSocket();

  @override
  void initState() {
    connectAndListen();
    super.initState();
  }

  void connectAndListen() {
    IO.Socket socket = IO.io('http://localhost:3000',
        OptionBuilder().setTransports(['websocket']).build());

    // socket.onConnect((_) {
    //   print('connect');
    //   // socket.emit('msg', 'test');
    // });

    //When an event recieved from server, data is added to the stream
    socket.on('data', (data) {
      streamSocket.addResponse(data.toString());
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void dispose() {
    streamSocket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: streamSocket.getResponse,
            builder: (context, snapshot) {
              return Center(
                  child: Text(
                snapshot.hasData ? '${snapshot.data}' : '',
                style: Theme.of(context).textTheme.displaySmall,
              ));
            },
          )
        ],
      ),
    );
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
