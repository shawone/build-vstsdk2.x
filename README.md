OSX Makefile to build VST with VST SDK 2.x

###Note
The purpose of this simple Makefile is to create a universal binary,
and compatible with osx architectures:
- x86_64
- i386
- ppc (not include)

ppc is not always supported on recent g++.

###Build / Install
- Due to licensing restrictions the VST SDK is not distributed here  

- VST SDK 2.x is still available in last version. Download and extract VST 3.6.5 or latest:
[http://www.steinberg.net/en/company/developers.html] (http://www.steinberg.net/en/company/developers.html)

- git clone this repository into VST3 directory

- Implement your code in that new repository (again.cpp or again.c in this example)

- build and add generated VST:   
`make`   
`cp -R ./build/shawone.vst /Users/$USER/Library/Audio/Plug-Ins/VST/`   

###Usage
Open the generated vst plugin under Reaper/Live or your favorite VST host
