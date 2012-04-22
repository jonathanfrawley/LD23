LD23
====
LittleEarth's Last Stand
Ludum Dare 23 Entry

How to Compile
====
To compile, you will need to download the Flex SDK and setup your path so that the $(FLEX_SDK)/bin directory is on your $PATH.
This process is described here : http://flashgamedojo.com/wiki/index.php?title=Hello_World_-_MXMLC_%28Flixel%29
You will also need the fcsh-wrap utility available here: http://flashgamedojo.com/wiki/index.php?title=Fcsh-wrap
or alternatively you can just replace ``fcsh-wrap`` with ``mxmlc`` in the Makefile.

Then you can simple type:

    make

To build the swf. If you are on linux and have the ``flashplayer`` standalone program, you can simply type 

    make run

to start the game.

License
====
GPLv3, see the LICENSE.txt for details.
