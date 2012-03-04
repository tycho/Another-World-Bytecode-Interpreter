
SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS = `sdl-config --libs`

#comment this line and uncomment the one below it to force detection
DEFINES:= -DAUTO_DETECT_PLATFORM
#DEFINES = -DSYS_LITTLE_ENDIAN

CXX = g++
CXXFLAGS:= -Os -g -std=gnu++98 -fno-rtti -fno-exceptions -fno-strict-aliasing
CXXFLAGS+= -Wall -pedantic -Wno-unknown-pragmas -Wshadow -Wundef -Wwrite-strings
CXXFLAGS+= -Wnon-virtual-dtor -Wno-multichar -Wno-variadic-macros -Wextra
CXXFLAGS+= $(SDL_CFLAGS) $(DEFINES)

ifneq ($(debug),)
CXXFLAGS += -DDEBUG
endif

SRCS = bank.cpp file.cpp engine.cpp mixer.cpp resource.cpp parts.cpp vm.cpp \
	serializer.cpp sfxplayer.cpp staticres.cpp util.cpp video.cpp main.cpp \
	sysImplementation.cpp

OBJS = $(SRCS:.cpp=.o)
DEPS = $(SRCS:.cpp=.d)

game: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(SDL_LIBS) -lz

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $*.o

uncrustify:
	uncrustify --no-backup -c uncrustify.cfg *.cpp *.h

clean:
	rm -f *.o *.d game

-include $(DEPS)

.PHONY: uncrustify clean
