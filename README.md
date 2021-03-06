CSCI 3308 Final Project - Social Networking Site

Members: Chris Poulton, Chris Gavin, Jean-Paul

The project is to make a social networking site like facebook. Users create an account that can be logged into. Within the site, users then search for friends that they know in real life by their last name. Friend requests can then be sent. If the other person accepts the friend request then the user can see the friend’s profile information along with their wall and has the ability to post things on the wall. Each user can a specific newsfeed that shows all the posts that have be written to their's and friends’ walls.

| Model | Purpose |
| ------------- | ------------- | 
| User  | Represents user information
| Post  | Represents information about each post
| Friendship | Records each friendship
| PendingFriendship | Holds each pending friendship request


| Controllers     | Purpose | 
| ------------- | ------------- | 
| Account | Controls routes that relate to the user account such as logging in and looking at current friends  | 
| Viewing | Controls routes that are for viewing other users and the newsfeed  |
| Friend  | Controls routes for requesting, adding, denying, and defriending friends |


| View    | Owning Controller | Purpose |
| ------------- | ------------- | ------------- | 
| login | Account  | Login page |
| new | Account  | Page to make a new user |
| friends | Account  | Page to view current friends |
| preferences | Account  | Page to change preferences and profile |
| newsfeed | Viewing | Page that contains newsfeed |
| profile | Viewing  | Page to look at user profile |
| _header | Application | Partial that is the header of all views |
| _message | Application | Partial that displays messages in the flash, used in all views |
| _postlist | Viewing | Partial that displays lists of posts, used in newsfeed and profile |
