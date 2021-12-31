# Kafka Mini Project

## Building A Streaming Fraud Detection System With Kafka and Python

## Objective

In this project, we create a streaming application backed by **Apache Kafka** using a **Python client**. This is a simple **real-time fraud detection system**. We will generate a stream of synthetic transactions and use Python script to process those stream of transactions to detect which ones are potential fraud.

## Prerequisites

Below is the folder map to all the files we have for the project:

```bash
.
├── docker-compose.yml 
├── detector
│ ├── Dockerfile
│ ├── app.py
│ └── requirements.txt
├── generator
│ ├── Dockerfile
│ ├── app.py
│ ├── transactions.py
│ └── requirements.txt
├── start.sh
├── start_main_docker_compose.sh
├── read_whole_topic.sh
├── restart.sh
├── stop.sh
```

## Topic

We will produce fake transactions on one end, filter and log those that look suspicious on the other end. This will include:
* a transaction generator (which produces the synthetic data for the process).
* a fraud detector.
Both applications will run in Docker containers and interact with the Kafka cluster.

### Architecture diagram

## The fraud detector mechanism

The fraud detector is a typical example of a stream processing application.
It takes a stream of transactions as an input, performs the filtering task, then outputs the result into two separate streams - those that are legitimate, and those that are suspicious, an operation also known as **branching**.

## picture

## Steps to run the application

1. From the Bash shell run:
```bash
$ chmod +w ./start.sh
$ ./start.sh
```

2. In another tab of Bash shell, run:
```bash
$ chmod +w ./start_main_docker_compose.sh
$ ./start_main_docker_compose.sh
```
The we should see this output:

3. Pressing `Ctrl + C` to strop the `kafka-console-consumer` and see the total number of the read messages:
## picture

4. Read the whole topic, run this command:
```bash
$ docker-compose -f docker-compose.kafka.yml exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic queueing.transactions --from-beginning
```

or run:

```bash
$ ./read_whole_topic.sh
```
Then `Ctrl+C` to cancel as below output:

# picture

5. Stop the generator and delete all the containers/networks/volumes:
```bash
$ ./stop.sh
```