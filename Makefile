PLUGIN_NAME = shawone
AUTHOR = shawone
VST_PATH = ../
ARCH_PPC = -arch ppc -mcpu=7450 -maltivec -maltivec -mabi=altivec
ARCH_INTEL = -arch i386
ARCH_X86_64 = -arch x86_64
VSTFLAGS = -x c++ -fmessage-length=0 -pipe -Wno-trigraphs -fpascal-strings -fasm-blocks -O3 -fvisibility-inlines-hidden -Wmost -Wno-four-char-constants -Wno-unknown-pragmas -Fbuild/
INCLUDES = -I$(VST_PATH) -I$(VST_PATH)/public.sdk/source/vst2.x -I$(VST_PATH)/pluginterfaces/vst2.x -I$(VST_PATH)/vstgui.sf/vstgui

all: clean build_sdk_i386 build_sdk_x86_64 vst_package create_plist bin_merge

build_sdk_i386:
	mkdir -p build/i386
	g++ $(VSTFLAGS) $(ARCH_INTEL) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/audioeffect.cpp -o build/i386/audioeffect.o
	g++ $(VSTFLAGS) $(ARCH_INTEL) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/audioeffectx.cpp -o build/i386/audioeffectx.o
	g++ $(VSTFLAGS) $(ARCH_INTEL) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/vstplugmain.cpp -o build/i386/vstplugmain.o
	g++ $(VSTFLAGS) $(ARCH_INTEL) $(INCLUDES) -c ./again.cpp -o build/i386/again.o
	g++ -arch i386 -bundle -Lbuild/i386 -Fbuild/i386 build/i386/again.o build/i386/audioeffect.o build/i386/audioeffectx.o build/i386/vstplugmain.o -framework Carbon -framework QuickTime -o build/i386/$(PLUGIN_NAME)

build_sdk_x86_64:
	mkdir -p build/x86_64
	g++ $(VSTFLAGS) $(ARCH_X86_64) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/audioeffect.cpp -o build/x86_64/audioeffect.o
	g++ $(VSTFLAGS) $(ARCH_X86_64) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/audioeffectx.cpp -o build/x86_64/audioeffectx.o
	g++ $(VSTFLAGS) $(ARCH_X86_64) $(INCLUDES) -c $(VST_PATH)/public.sdk/source/vst2.x/vstplugmain.cpp -o build/x86_64/vstplugmain.o
	g++ $(VSTFLAGS) $(ARCH_X86_64) $(INCLUDES) -c again.cpp -o build/x86_64/again.o
	g++ -arch x86_64 -bundle -Lbuild/x86_64 -Fbuild/x86_64 build/x86_64/again.o build/x86_64/audioeffect.o build/x86_64/audioeffectx.o build/x86_64/vstplugmain.o -framework Carbon -o build/x86_64/$(PLUGIN_NAME)

create_plist:
	echo "$(PLUGIN_NAME)</string>" >> build/$(PLUGIN_NAME).vst/Contents/Info.plist
	echo "<key>CFBundleIconFile</key><string></string><key>CFBundleIdentifier</key>" >> build/$(PLUGIN_NAME).vst/Contents/Info.plist
	echo "<string>com.$(AUTHOR).$(PLUGIN_NAME)</string>" >> build/$(PLUGIN_NAME).vst/Contents/Info.plist
	echo "<key>CFBundleInfoDictionaryVersion</key><string>6.0</string><key>CFBundlePackageType</key><string>BNDL</string><key>CFBundleSignature</key><string>????</string><key>CFBundleVersion</key><string>1.0</string><key>CSResourcesFileMapped</key><true/></dict></plist>" >> build/$(PLUGIN_NAME).vst/Contents/Info.plist

bin_merge:
	lipo -create build/i386/$(PLUGIN_NAME) build/x86_64/$(PLUGIN_NAME) -output build/$(PLUGIN_NAME).vst/Contents/MacOS/$(PLUGIN_NAME)
	touch build/$(PLUGIN_NAME).vst

vst_package:
	mkdir build/$(PLUGIN_NAME).vst
	mkdir build/$(PLUGIN_NAME).vst/Contents
	mkdir build/$(PLUGIN_NAME).vst/Contents/Resources
	mkdir build/$(PLUGIN_NAME).vst/Contents/MacOS
	cp InfoPart.plist build/$(PLUGIN_NAME).vst/Contents/Info.plist
	touch build/$(PLUGIN_NAME).vst/Contents/PkgInfo
	echo "BNDL????" > build/$(PLUGIN_NAME).vst/Contents/PkgInfo

clean:	
	rm -rf build
