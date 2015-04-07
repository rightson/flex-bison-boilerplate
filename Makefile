TARGET := run_parser
CXXFLAG := -g -lm
SCANNER := scanner.flex.cpp
PARSER := parser.bison.cpp
HANDLER := mainParser.hpp
CLIENT := main.cpp

$(TARGET): $(SCANNER) $(PARSER) $(CLIENT)
	$(CXX) $(CXXFLAG) -o $@ $^

$(SCANNER): scanner.l
	flex -o $(SCANNER) $<

$(PARSER): parser.y $(HANDLER)
	bison -o $(PARSER) $<

flex:
	flex -o $(SCANNER) scanner.l

bison:
	bison -d -o $(PARSER) parser.y

build:
	$(CXX) $(CXXFLAG) -o $(TARGET) $(SCANNER) $(PARSER) $(CLIENT)

clean:
	rm -f *.flex.cpp *.flex.hpp
	rm -f *.bison.cpp *.bison.hpp
	rm -fr *.dSYM
	rm -f $(TARGET)

.PHONY: clean flex bison build
