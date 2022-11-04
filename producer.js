const { Kafka } = require("kafkajs");

const main = async (val) => {
  try {
    const kafka = new Kafka({
      clientId: "my-app",
      brokers: ["localhost:9092"],
    });

    const producer = kafka.producer();
    await producer.connect();
    await producer.send({
      topic: "kafka-poc",
      messages: [{ value: val }],
    });

    await producer.disconnect();
  } catch (e) {
    console.log("Something went wrong: " + e);
  }
};

const cars = [
  "Saab",
  "Volvo",
  "BMW",
  "Benz",
  "Toyota",
  "Lexus",
  "Honda",
  "Gac",
  "Audi",
];
let index = 0;

setInterval(() => {
  let car = cars[index];
  main(car);
  if (index == cars.length - 1) {
    index = 0;
  }
  index++;
}, 1000);
