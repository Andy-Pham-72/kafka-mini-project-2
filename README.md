# Kafka Mini Project

## Building A Streaming Fraud Detection System With Kafka and Python
![Screen Shot 2021-12-31 at 4 09 01 PM](https://user-images.githubusercontent.com/70767722/147839040-e395bdd8-1320-4948-ae11-38264656c86f.png)

## Objective:

In this project, we create a streaming application backed by **Apache Kafka** using a **Python client**. This is a simple **real-time fraud detection system**. We will generate a stream of synthetic transactions and use Python script to process those stream of transactions to detect which ones are potential fraud.

## Prerequisites:

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

We will produce fake transactions on one end, filter and log those that look suspicious on the other end. This will include:
* a transaction generator (which produces the synthetic data for the process).
* a fraud detector.
Both applications will run in Docker containers and interact with the Kafka cluster.

### Architecture diagram

![Screen Shot 2021-12-31 at 3 57 29 PM](https://user-images.githubusercontent.com/70767722/147838824-3a6cfb90-d06d-4b1a-9daf-10490fa923a4.png)


## The fraud detector mechanism

The fraud detector is a typical example of a stream processing application.
It takes a stream of transactions as an input, performs the filtering task, then outputs the result into two separate streams - those that are legitimate, and those that are suspicious, an operation also known as **branching**.

![Screen Shot 2021-12-31 at 3 57 49 PM](https://user-images.githubusercontent.com/70767722/147838831-f440402a-cabb-4da6-af4b-e5c9e68f9375.png)

**Assumption:**
Since in the real world, deteching fraud is a complex problem and it depends on so many different metrics to determine fraud. In this project, we will keep the metric simple which it is illegal to send more than **$900.00** at a time. As a result, any transaction whose amount is greater than 900 can be considered as fraud.

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
![Screen Shot 2021-12-31 at 3 45 33 PM](https://user-images.githubusercontent.com/70767722/147838855-f39b568f-52c5-4ea8-ae4d-e4383ba7d75f.png)

We can see the legit transaction which lower than our metric which is: $900.00
![Screen Shot 2021-12-31 at 3 46 17 PM](https://user-images.githubusercontent.com/70767722/147838880-a2ad89d3-3240-4b0c-bb8a-989a7ee1e71e.png)

3. Read the whole topic, run this command:
```bash
$ docker-compose -f docker-compose.kafka.yml exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic queueing.transactions --from-beginning
```

or run:

```bash
$ ./read_whole_topic.sh
```
and see the total number of the read messages, Run `Ctrl + C`:
![Screen Shot 2021-12-31 at 4 14 27 PM](https://user-images.githubusercontent.com/70767722/147839182-0e98eede-ec68-4c4b-b980-515ab0c4f406.png)

4. Run `Ctrl + C` to stop the `kafka-console-consumer` 
or
Stop the generator and delete all the containers/networks/volumes:
```bash
$ ./stop.sh
```
