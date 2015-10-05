OSX Makefile to build VST with VST SDK 2.x

/* Note */
Makefile is in "shawone" directory.
The purpose of this simple Makefile is to create a universal binary,
and compatible with osx architectures:
- x86_64
- i386
- ppc (not include)

ppc is not always supported on recent g++.

/* Build / Install */
- download and extract VST 3.6.5 or latest:
http://www.steinberg.net/en/company/developers.html

- cp again.cpp and again.h examples located in:
[...]/VST3 SDK/vstgui4/vstgui/tutorial/vstsdk2.4/public.sdk/samples/vst2.x/again/source/

- git clone this repository into VST3 directory
 
- build and add generated VST:
make
cp -R ./build/shawone.vst /Users/$USER/Library/Audio/Plug-Ins/VST/

/* Usage */
Open VST example under Reaper/Live or other VST compatible software
Load plugin, in this example name is "gain" and vendor is "Steinberg Media Technologies"
