const { Kafka } = require("kafkajs");
const server = require("http").createServer();
const io = require("socket.io")(server, {
  cors: {
    origin: "*",
  },
});

io.on("connection", (socket) => {
  console.log("new client connected");
  const main = async () => {
    const kafka = new Kafka({
      clientId: "my-app",
      brokers: ["localhost:9092"],
    });

    const consumer = kafka.consumer({ groupId: "" + Date.now() });
    await consumer.connect();
    await consumer.subscribe({ topic: "kafka-poc", fromBeginning: true });
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        socket.emit("data", message.value.toString("utf8"));
      },
    });
  };
  main();

  socket.on("disconnect", () => {
    console.log("client disconnected");
  });
});

server.listen(3000, () => {
  console.log("Server listening on localhost:3000");
});
