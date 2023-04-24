W        = -Wall
OPT      = -O2
STD      = -std=c++17
CXXFLAGS = $(STD) $(OPT) $(W) -fPIC $(XCXXFLAGS)
INCS     = -Isrc/uws/

SRCS = src/uws/Extensions.cpp src/uws/Group.cpp src/uws/Networking.cpp src/uws/Hub.cpp src/uws/Node.cpp src/uws/WebSocket.cpp src/uws/HTTPSocket.cpp src/uws/Socket.cpp src/uws/Epoll.cpp src/uws/Room.cpp

OBJS := $(SRCS:.cpp=.o)


.PHONY: clean all install


all: libuWS.a libuWS.so

clean:
	rm -f src/uws/*.o libuWS.a libuWS.so

install:
	$(eval PREFIX ?= /usr/local)
	cp libuWS.a libuWS.so $(PREFIX)/lib/
	mkdir -p $(PREFIX)/include/uWS
	cp src/uws/*.h $(PREFIX)/include/uWS/

%.o : %.cpp %.d Makefile
	$(CXX) $(CXXFLAGS) $(INCS) -c $< -o $@

libuWS.a: $(OBJS)
	$(AR) rs $@ $(OBJS)

libuWS.so: $(OBJS)
	$(CXX) $(LDFLAGS) -shared -o $@ $(OBJS)
