#include <string>

class tokenValues {
	public:
		union {
			std::string 	*string_value;
			int				integer_value;
			double 			double_value;
			bool			bool_value;
		} token;
};

typedef tokenValues YYSTYPE;
#define YYSTYPE_IS_DECLARED 1
