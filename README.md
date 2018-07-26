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
- add new note
- remove note (swipe on table view)
- edit note
- localization
- XCTest - presented
- some methods and properties are documented 

Notes.
 
There are some issues with API.
Does not work some requests.

PUT /notes/{id}
I tried to send JSON (for example, i tried different):
{"id":1,"title":"Jogging in park"}
status code is 201 but nothing happened on the server (I expected to add a new record or update existed)

07-25-2018
Sergey Krotkih

Note.
Please feel free to learn my another source code examples in Swift and Objective-C:
https://github.com/SKrotkih/eMia-iOS
https://github.com/SKrotkih/YTLiveStreaming
