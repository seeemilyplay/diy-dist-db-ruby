Part of the SPA 2015 Distributed Databases session. Start here if you'd like
to do the workshop in Ruby. This project will set you up with all the
boring code that talks to a node via its REST API. At the moment this code
can only talk to one node, it's your job to make it work with multiple,
distributed nodes.

## Running

Install the `rest-client` package that is used for dealing with http requests.

    gem install rest-client 

Start up at least one node with:

    diy-dist-db-node 8080

Run the Ruby program with:

    ruby lib/dist-db/main.rb 

# What's here

All code is in the `lib/dist_db` directory. There are four files:

1. `thing.rb`: Defines the class `Thing` that represents the things stored
in the db.
2. `node.rb`: A module that wraps around the node's REST API and deals
with the HTTP calls for you.
3. `dist_db.rb`: Contains all the distributed logic for reading and writing
across multiple nodes. Your code will go here.
4. `main.rb`: A simple script that tries out the database by reading and
writing values. You may want to change this too.

## Writing code

As mentioned above, most of your code will be in `dist_db.rb`, but you may
also want to change the `main.rb` too.
 
