# 2 - Filters Implementation

**This part is optional and is not necessary for job application!**
In this part you're going to implement basic filters for audience browser.
Be aware that we assume that you've already completed [first step](/FIRST_STEP.md) since that implementation
is what is required for this step.

In this step you will implement basic filter for our previously built audience browser.
This will split original tree of `audience`s to three independent trees user can chose from.

## Requirements

There are three categories of audiences we want to separate in data set.
User should be able to select one of these at the time and see only audiences which are member of this category.
Categories are:

- authored audiences - audiences created by user herself.
- shared audiences - audiences which other users shared with user.
  - In this case structure is flat.
- curated audiences - pre-build audiences provided to all users.

### This is requirements for this step:

- [ ] You must not change any of pre-defined types and fixtures.
    - However you can use existing files for your implementation.
- [ ] Add 3 buttons - one for every category of audiences.
- [ ] Clicking on each button activate particular category of audience.
- [ ] By default `Authored` audiences are filtered.
- [ ] There must by at least one category selected at the time.
- [ ] Every-time user changes category she sees its root level.
- [ ] In case of shared audiences ignore tree structure and display audiences in single level without any folder.
- [ ] Final solution should be compilable to html app or should contain HTML and source compilable to JavasCript included in HTML.

## Final Words

Thank you for picking up this challenge!
You're amazing. I have no words.
As always let us know in case you need any help.
**Good luck!**:rocket:
