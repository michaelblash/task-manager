# Task Manager

  Task Manager app allows to add and track tasks for any authorized user. Users that is granted with admin role may observe and edit other user's tasks. Users can easily filter their tasks by priority and status.

  ## Requirements

  * Node.js
  * PostgreSQL

  ## Installation guide

  1. Import the `tasks.sql` database:

```bash
$ psql -d tasks -f tasks.sql
```

  2. Pull all the project dependencies:

```bash
$ npm install
```

  ## Usage

  1. Make a proper database settings in `config.js` file.

  2. Run the following command from project root directory:

```bash
$ node app.js
```
