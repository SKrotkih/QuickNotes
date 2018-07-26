# QuickNotes

Simple native iPhone application for management of personal notes.

## Requirements

- Xcode 9.4.1
- Objective-C

## Install and Launch the App

- clone or unzip the repository. 
- go to the root folder. 

Open QuickNotes.xcworkspace
Select QuickNotes scheme.
Select iOS 11 iPhone simulator.
Start he app by pressing Command+R

## Features

- browse all notes
- auto resizing rows on the tableview
- add new note
- remove note (swipe on tableview)
- edit notes
- localization - presented
- XCTest - presented
- some methods and properties are documented 
- MVVM

Notes.
 
There are some issues with API.
Does not work some requests for me so does not work adding and editing notes functionality. 

For example:
PUT /notes/{id}
I tried to send JSON (for example, i tried different):
{"id":1,"title":"Jogging in park"}
status code is 201 but nothing happened on the server (I expected to add a new record or update existed)
in response JSON with next Note (by Id).
(QNServiceInteraction.m)

07-25-2018
Sergey Krotkih

Note.
Please feel free to learn my another source code examples in Swift and Objective-C:
https://github.com/SKrotkih/eMia-iOS
https://github.com/SKrotkih/YTLiveStreaming
