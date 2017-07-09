API URL
=========
Link to API: connect.lchsspartans.net/api/

(or api.connect.lchsspartans.net?)

List of API Routes
==================

+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Link                         | Method   | Description                                                                                                                                                                            |
+==============================+==========+========================================================================================================================================================================================+
| announcements/               | GET      | Retrieves all announcements.                                                                                                                                                           |
|                              |          | Additional Parameters: startDate, endDate, quantity                                                                                                                                    |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| announcements/current        | GET      | Retrieves all current announcements                                                                                                                                                    |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| announcements/               | POST     | Creates an announcement with given POST information.                                                                                                                                   |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| announcements/:id/           | POST     | Updates an announcement with given POST information.                                                                                                                                   |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| announcements/:id/           | GET      | Retrieves information on a certain announcement with given ID.                                                                                                                         |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|                              |          | announcement/:id/events, tags, and deadlines are not included as they are already part of the announcement object                                                                      |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| tags/                        | GET      | Retrieves all tags.                                                                                                                                                                    |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| tags/:id/                    | GET      | Retrieve information on a certain tag with given ID.                                                                                                                                   |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| tags/:id/announcements       | GET      | Retrieves a list of announcements with a certain tag id                                                                                                                                |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| events/                      | GET      | Retrieves all events.                                                                                                                                                                  |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| events/:id/                  | GET      | Retrieve information on a certain event with given ID.                                                                                                                                 |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/                       | GET      | (locked to one or lower) Returns a list of all users.                                                                                                                                  |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/:id                    | GET      | (locked to one or lower) Returns information on user with specific ID                                                                                                                  |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/:id                    | POST     | (locked to level zero or the user) Modifies user information.                                                                                                                          |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/:id/announcements      | GET      | Gets all announcements from a given user.                                                                                                                                              |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/:id/notifications      | GET      | (locked to level zero or the user) Returns the notifications of the user.                                                                                                              |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/login                  | POST     | Authorize a Google account, taking in a one time code sent after the frontend contacts Google. Returns false and a consent url if the login was not valid or there was no data sent.   |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/login                  | GET      | Returns a consent url for the app to use to login.                                                                                                                                     |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| users/me (redirect to :id)   | GET      | Gets the current user.                                                                                                                                                                 |
+------------------------------+----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Data Structures
===============

Announcement
------------

An announcement object.

Properties:
-  id: unique id for the announcement, same as that in the db
-  title (alias: name): the title line, pretty straight forward
-  description: a string with the complete description for the announcement (basically the body)
-  creator (alias: author, user): the user object of the creator
-  approver: a user object that describes who approved an announcement
-  startDate: the first day that the announcement is displayed
-  endDate: the last day the announcement is displayed
-  urgent: whether or not the announcement is urgent or not
-  approved: a single digit integer displaying its approval status

   -  0: pending approval
   -  1: approved
   -  2: denied by admin
   -  3: removed by author

-  timeSubmitted: The datetime of when the announcement was submitted
-  tags: (Tags[]): Returns an array of tag objects applied to the announcement
-  events: (Events[]): Returns an array of event objects applied to the announcement
-  deadlines: (Deadlines[]): Returns an array of the deadlines that are attached to the announcement

Tag
---

A tag object.

Properties:
-  id: unique ID for the applied tag
-  name: display name for tag
-  slug: the technical name for the tag
-  visible: single bit: whether the tag is visible when the announcement is displayed
-  minUserLevelAssign: single digit int: the minimum level that the user must be to be able to assign or approve the assignment of this tag
-  minUserLevelRequest: single digit int: the minimum level that the user must be to be to request that his/her announcement be assigned this tag
-  parentId (alias: parentID) if the tag is a child of another tag, the ID of the parent is put here, likely null for the moment
-  isCritical: boolean that states whether the tag can be modified

User
----

A user object.

if a user has a rank higher than 1, they can change any email or user to
a power level less than our equal to their own. if a user has a rank of
1, they can set any user to level 0.

Properties:
-  id: number a unique id for the user
-  name: the name of the user
-  handle: the username of the user
-  email: the email of the user
-  rank: a single digit integer indicating the user’s permissions

   -  3: teacher: submit announcements, edit their own existing announcements
   -  2: admin: teacher perms+approve/deny submitted announcements, edit any announcement, set urgent tag at will
   -  1: superAdmin: admin perms+ability to set emergency tag
   -  0: maintenanceUser: superAdmin perms+maintenance panel w/ diagnostics, and direct sql access (hopefully), making tags

-  postCounts: object with number of posts that the user has made

   -  approved: int of number of approved announcements
   -  unapproved: int of number of unapproved announcements
   -  denied: int of number of admin denied announcements
   -  removed: int of number of user self-removed announcements
   -  total: int of total number of announcements

-  lastLogin: a timestamp of when the user last logged in

Event
-----

An event object (to be implemented)

Properties:
-  id: a unique id of the event
-  title (alias: name): the title line of the event
-  description: the description of the event
-  announcementID the announcement ID of which the event is a child

   -  announcement: the announcement parent with the id of the above announcementId

-  allDay: single bit determining whether the event is all day or not
-  date: the date of the event.
-  startTime: the start time of the event
-  endTime: the end time of the event

Responses
=========

Response
--------

The response that is returned by the server from any endpoint.

Properties:
-  success: boolean returns true if successful, false if not
-  error: string

AnnouncementResponse
--------------------

(inherits Response)

The response that is returned by the server when announcements are
requested.

Properties:
-  response: announcement []: an array of announcement objects which are the actual announcements that are returned
-  All Response properties

EventResponse
-------------
(inherits Response)
The response that is returned by the server when events are requested.

Properties:
-  response: event []: an array of event objects which are the actual events that are returned
-  All Response properties

TagResponse
-----------
(inherits Response)
The response that is returned by the server when tags are requested.

Properties:
-  response: tag []: an array of tag objects which are the actual tags that are returned
-  All Response properties

UpdateResponse
--------------
(inherits Response)
The response the is returned by the server when a POST is sent.

Properties:
-  affectedRows: returns the number of affected rows
-  response: returns true for success, false for error

Links
=====

announcements/ (GET)
--------------------
Returns an AnnouncementResponse which returns all current announcements.

-  if a quantity is given, that number of announcements is returned
-  if a tagId is given, a list of announcement objects with that tag will be returned in the array
-  if start and end dates are added, only announcements visible between the two dates (exclusive) are returned

announcements/ (POST)
---------------------
Web app sends server a json announcement object, with a null id. Returns
an UpdateResponse.

-  Required: title, description, startDate, endDate, tags (ids or slugs)
-  Assumed: userId
-  Optional: events

announcements/:id (GET)
-----------------------
Gets an AnnouncementResponse with the announcement by id.

announcements/:id (POST)
------------------------
Web app sends server a list of announcement properties and updated
values. Returns an UpdateResponse.

-  Optional: title, description, startDate, endDate
-  Elevation Required: approved, urgent

For updating events or tags, use the POST methods for /announcements/:id/events or /announcements/:id/tags. These often have an addXxxx/removeXxxx property to pass in that is an array of tag/event ids.

users/login
------------
Logs in a user (or creates one if the email is not used before) based on
the one-time token given.
