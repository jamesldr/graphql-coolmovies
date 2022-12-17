


- [Introduction](#introduction)
- [Requirements](#requirements)
- [Running the server](#running-the-server)
- [Play around with some examples](#play-around-with-some-examples)
- [Reinitializing the database with seed data](#reinitializing-the-database-with-seed-data)
- [Run the app](#run-the-app)

## Objective

The purpose of this project is to practice the use of GraphQL queries, there are some requirements to run this project and they're listed in the sections below.


## Requirements

- Docker, a recent version (>= 20)
- Docker Compose (one compatible with above docker)
- Your local ports 5432 and 5001 are free (not running another postgres server, for instance)
- Flutter version 3.3.9
- Dart version 2.18.5

You need docker and docker compose installed on your machine. It supports Linux, MacOS and Windows.

If it's your first time, you can follow the official instructions:
https://docs.docker.com/desktop/
https://docs.docker.com/compose/install/

## Running the server

    cd coolmovies-backend
    docker-compose up

Wait for a log message like this: `PostGraphile v4.12.3 server listening on port 5000` (just keep in mind that we are going to use port 5001)

Now try to connect to GraphiQL and play around with the schema: http://localhost:5001/graphiql

The actual endpoint to run your queries and mutations: http://localhost:5001/graphql

## Play around with some examples

Now that your backend is working, you can play around with some queries and mutation that we already built as example. Keep in mind that running mutations here you will be actually mutating the data in your backend, but don't worry if you have an accident! In the next section we explain you how to reset your server database.

We are using Insomnia to provide you some examples. If you don't know about Insomnia you can think about it as another Postman application.

You can install Insomnia from here: https://insomnia.rest

Once that you have it running, you can import Insomnia_Collection.json from the `backend` folder.

## Reinitializing the database with seed data

So you were playing with the mutations and deleted something you shouldn't, no problem!

Go to the `coolmovies-backend` folder using your preferred terminal, then:

    docker-compose down
    docker volume rm coolmovies-backend_db
    docker rmi coolmovies-db:latest
    docker-compose up

If you want also to rebuild the Postgraphile Server, run this before the `up` command.

    docker rmi coolmovies-graphql:**latest**

## Run the app
To run the app, first, you have to go to the `coolmovies_mobile` folder using your preferred terminal, then run the command below, make sure you did <b>initialize the database</b> (<i>[Running the server](#running-the-server)</i>)
```
flutter pub get
flutter run
```


# App Screenshots

## Home Page
![image](https://user-images.githubusercontent.com/38454613/206932766-c0a77ef4-8212-434a-97ed-78b15de58636.png)

## Movie Info Page
![image](https://user-images.githubusercontent.com/38454613/206932804-a8142cea-f4d9-4ac5-8270-293309c0e659.png)


## Movie Reviews
![image](https://user-images.githubusercontent.com/38454613/206932832-c117a920-31a3-4c4d-8b6b-af61a36e584f.png)


## Review Form Modal
![image](https://user-images.githubusercontent.com/38454613/206932892-751e8fb1-2f6a-45ba-9ba1-da58494699fc.png)

