#include <string>

class tokenValues {
    public:
        std::string     *String;
        char            *Character;
        int             Integer;
        double          Floating;
        bool            Boolean;
};

typedef tokenValues YYSTYPE;
#define YYSTYPE_IS_DECLARED 1
