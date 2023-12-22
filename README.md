## wrath-v2

wrath is a computer virus made by me with the help of chat gpt.
this was made for fun, without malicious intent

wrath used a powershell script to bypass some restrictions implented by windows to stop viruses. wrath is a very simple virus and does not inject its code into executables but rather replaces them with itself. wrath also has a discord webhook built into it so it notifys me when it infects a new machine. wrath currently has no payload, all it does is infect files, i plan to release a new version in the future with a payload.

if you want to join the discord server with the webhook you can here: https://discord.gg/K98zxMeG

# how to use

1. disable windows defender before downloading to pervent the downloads from being blocked.
2. download, and extract the .zip file
3. run setup.exe as admin and go through the installation proccess
4. once it is installed it should run automaticly
5. press 1 to start or 2 to add the device as a blacklist
6. when it starts it will ask you to run the powershell script, you can do this by either copy pasting the script into powershell or downloading it, right click > run with powershell (the script has some issues with it i will fix later :/ )
7. after it infects your files it should be done.

# changelog

 wrath v2.42.5 i added a update checking and fixed a bug with post infectetion instructions. i will soon be switching some packages in favor of more stable ones.

 wrath v2.24.6 fixed a bug with text on the terminal window when going from pre infection to post infection. fixed the update checker after i renamed the repo
