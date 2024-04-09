# Student Calendar

This is the repo for the mobile app for Student Calendar
[Check the repo for the backend and webapp here](https://github.com/samudebug/student-calendar)

This is an app that allows students to create class calendars and schedule the dates of important tasks, assignments, exams, etc.

An user can create or join a class. While being on a class, they can create a task on said class, defining a deliver date and extra notes for that task, like reference materials for example.

### Structure

The app is built using [Flutter](https://flutter.dev/) using [GetX](https://pub.dev/packages/get) for route, state and dependency management.

The app uses a custom built API to store data.
It uses [Firebase Authentication](https://firebase.google.com/docs/auth) to handle user authentication using Email and Password as well as Google Sign-in.
