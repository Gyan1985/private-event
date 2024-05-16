# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Requirements
- Ruby ~> 3.0.0
- Rails ~> 7.0.8
- PostgreSQL
- Other dependencies are listed in the `Gemfile`.

## Installation

#1. Clone the repository:

```bash
git clone https://github.com/Gyan1985/private-event.git
cd private-event
```

#2. Install dependencies:

```bash
bundle install
```

#3. Set up the database:

```bash
rails db:create
rails db:migrate
```

#4. Seed the database with initial data:

```bash
rails db:seed
```

## Running the Application

To start the server, run:

```bash
rails server
```

This will start the server at [http://localhost:3000](http://localhost:3000).

## Testing

Run the tests using RSpec:

```bash
rspec
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes or enhancements.
