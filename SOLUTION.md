# This is aditional info to my solution of GWI javascript challenge

For solution I used EmberJS although I have no previous experiences with this FW 
so maybe some part could be created not fully by best practices of Ember.
Ember project is in `audiences` folder.

For mocking API endpoint I used Mirage extension for Ember but I requiring JSON sample data 
from external source didn't work for me, even if I tryed rewrite it to module or use some library
which is do it same thing directly from JSON file. 
So all JSON data are included in [Mirage config file](audiences/mirage/config.js).

## ELM solution

Because challenge is called javascript-elm I made decision create some Elm version of app. 
With Elm is the same as with EmberJS, it is my first project created in this language so maybes 
some solutions aren't best ones for Elm principes. 
Elm app version is without `elm-stuff` folder so for compiling is necesery provide `elm-make` commannd to create this folder.

For case you don't have installed `Elm`, you can simply run included builded otput `audiencesElm/index.html`.

Simply:
```
cd audiencesElm
npm run start
```

## Commits
I created several commits for easier review. 
One is empty fresh created Ember project, another is code written by me.
