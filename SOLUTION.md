# This is aditional info to my solution of GWI javascript challenge

For solution I used EmberJS although I have no previous experiences with this FW 
so maybe some part could be created not fully by best practices of Ember.
Ember project is in `audiences` folder.

For mocking API endpoint I used Mirage extension for Ember but I requiring JSON sample data 
from external source didn't work for me, even if I tryed rewrite it to module or use some library
which is do it same thing directly from JSON file. 
So all JSON data are included in [Mirage config file](audiences/mirage/config.js).

## Commits
I created several commits for easier review. 
One is empty fresh created Ember project, another is code written by me.
