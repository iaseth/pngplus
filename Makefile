AMP = @

AR = ${AMP}ar

CC = ${AMP}g++
CC_FLAGS = -fPIC -Wall

INCLUDE_FLAG = -Iinclude
LINK_FLAG = -lpng

RM = ${AMP}rm -f

PNGPLUS_NAMES = 
PNGPLUS_NAMES += pngplus

PNGPLUS_OBJ_NAMES = ${addsuffix .o, ${PNGPLUS_NAMES}}
PNGPLUS_OBJS = ${addprefix build/obj/, ${PNGPLUS_OBJ_NAMES}}

PNGPLUS_STATIC_LIB = build/lib/libpngplus.a
PNGPLUS_DYNAMIC_LIB = build/lib/libpngplus.so

MAIN_SRC = src/pngplus.cpp
MAIN_OBJ = build/pngplus.o

BIN = build/pngplus

default: ${BIN}

debug:
	${eval AMP := }

${MAIN_OBJ}: ${MAIN_SRC}
	${CC} -c $< -o $@ ${INCLUDE_FLAG}

${PNGPLUS_OBJS}: build/obj/%.o: lib/%.cpp include/%.hpp
	${CC} -c ${CC_FLAGS} $< -o $@ ${INCLUDE_FLAG}

${PNGPLUS_STATIC_LIB}: ${PNGPLUS_OBJS}
	${AR} rcs $@ $^

${PNGPLUS_DYNAMIC_LIB}: ${PNGPLUS_OBJS}
	${CC} -shared $^ -o $@

${BIN}: ${MAIN_OBJ} ${PNGPLUS_STATIC_LIB}
	${CC} $^ -o $@ ${LINK_FLAG}

lib: ${PNGPLUS_STATIC_LIB} ${PNGPLUS_DYNAMIC_LIB}

redo: clean default

run: ${BIN}
	@${BIN}

move:
	sudo cp ${BIN} /usr/bin

clean:
	${RM} ${BIN}
	${RM} ${PNGPLUS_STATIC_LIB}
	${RM} ${PNGPLUS_DYNAMIC_LIB}
	${RM} ${MAIN_OBJ}
	${RM} ${PNGPLUS_OBJS}


