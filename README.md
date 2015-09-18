# InfinityMirror
Rails and JavaScript-based roguelike RPG.

# Back story

One morning while playing in the attic of your late grandfather's house you stumble onto a very special mirror, the infinity mirror, that will forever alter your life.
You are trapped in a world that exists between worlds accessible only through the infinity mirror. The only way out is through magic that is only attainable through exploring the new world and developing your magical abilities. 
Your fate is in your own hands... 

# Goal

 * Advance through stages by finding keys to open locked doors.
 * Search areas for magic chests that give you useful items and magic scrolls.
 * Develop your magic abilities to defeat monsters that block your path on your journey home.
 
# Controls

Number pad or the arrow keys

# Setup

This server requires Ruby version 2.2.3 (https://www.ruby-lang.org/en/downloads/)
 * Once you have Ruby installed, within a terminal, navigate to the project directory ~/InfinityMirror/
 * Execute the following (without quotes): `bundle install`
 * With all the project gems installed you're ready to run the server with the following (without quotes): `./bin/rails server` which will execute a Webrick server you can reach from a browser.
 * Open your favorite browser and navigate to the address and port you specified above. By default your rails server will be running at http://0.0.0.0:3000
 
# Notes

At the present this is a very rough prototype that only demonstrates dynamic dungeon creation, a simple player (represented by a green '@') and some chests (represented by '[]'). The end goal will be to introduce non-player characters and a simple path finding algorithm (probably A*) as enemies for the player to battle with and gain experience to level the player up.
My initial thoughts were to have the player advance to the next level once all the enemies were destroyed and the hidden objects were discovered. When a player dies then that's it and it's game over but I'm not a huge fan of permadeath games so I will revist this thought as the game grows...
