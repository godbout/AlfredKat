<h1 align="center">Alfred KAT</h1>

<p align="center">
    <a href="https://apps.apple.com/us/app/macos-catalina/id1466841314?mt=12"><img src="https://img.shields.io/badge/macOS-10.15.7 Catalina%2B-yellowgreen"></a> 
    <a href="https://github.com/godbout/AlfredKat/releases"><img src="https://img.shields.io/github/release/godbout/AlfredKat.svg" alt="GitHub Release"></a>
    <a href="https://github.com/godbout/AlfredKat/actions"><img src="https://img.shields.io/github/actions/workflow/status/godbout/AlfredKat/main.yml?branch=master" alt="Build Status"></a>
    <a href="https://app.codacy.com/gh/godbout/AlfredKat"><img src="https://img.shields.io/codacy/grade/5de193eef6ef499c86f7abebc667e4dd" alt="Quality Score"></a>
    <a href="https://codecov.io/gh/godbout/AlfredKat"><img src="https://img.shields.io/codecov/c/gh/godbout/AlfredKat" alt="Code Coverage"></a>
    <a href="https://github.com/godbout/AlfredKat/releases"><img src="https://img.shields.io/github/downloads/godbout/AlfredKat/total.svg" alt="GitHub Downloads"></a>
</p>

___

# WHAT IS THAT

Get your KAT torrents without all the advertising crap. Type "kat" followed by what you're looking for, wait a bit (it's quick), choose your torrent and make some space on your HD.

Now you can also use #tags, like #music or #movies or more.

Now you can also sort by ^date, ^size, ^seeders or ^leechers. if you're too lazy to type there's shortcuts: ^1 ^2 ^3 ^4.

# MANDATORY SCREENSHOT

![Beautiful Video](https://github.com/godbout/AlfredKat/blob/media/AlfredKat.gif "Beautiful Video")

# WHY IS THAT

There's a [KAT workflow](http://www.packal.org/workflow/kat-search) already on [packal.org](http://www.packal.org), but it doesn't work for me (SSL error). I contacted the author but got no answer, so I built this one. If the other one on Packal works it might be better to use it, it might have more options, or maybe not, I don't know, la la la la la.

# SETUP

NO SETUP! But the KAT URL is an Alfred workflow variable so you can replace it with a mirror in case the main site is down.

# PRO USERS

The workflow opens the magnet with the magnet default application of your Mac. If you prefer using a command-line client, you can add a `cli` variable in the [Workflow Environment Variables](https://www.alfredapp.com/help/workflows/advanced/variables/#environment). The value should be the full path to your torrent client with a `{magnet}` variable that will be replaced by the selected magnet (e.g. `/usr/local/bin/transmission-remote -a {magnet}`).

You can also copy the magnet to the clipboard rather than opening it (and starting the download) by using the ⌘ modifier.

# HUH WASNT THIS WRITTEN IN PHP B4?

Totally. But Apple is getting rid of interpreters in macOS. That means that to use this Workflow I would have to ask you to install PHP. And probably some specific version. And probably in some specific place. That Sucks™. So it's now written in Swift.

PHP version is still available here: https://github.com/godbout/alfred-kat. It will be missed. Source code was beautiful. (The last comment might be due to delusion of grandeur.)

# BUT YOU LOST ALL YOUR DOWNLOADS COUNT LMAO

WHO GIVES A SHIT.

# DOWNLOAD

[Release page](https://github.com/godbout/AlfredKat/releases/latest)
