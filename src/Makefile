MXMLC = fcsh-wrap
FLIXEL = $HOME/projects/flash/flixel
SRC = Game.as PlayState.as
MAIN = Game.as
SWF = Game.swf
 
$(SWF) : $(SRC)
	$(MXMLC) -static-link-runtime-shared-libraries $(MAIN)

run: clean $(SWF)
	flashplayer $(SWF)

clean:
	rm -f $(SWF)
