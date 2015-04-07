#include <string>

enum tokenTypeEnum {
	enumUnknownType = 0,
	enumStringType,
	enumIntegerType,
	enumDoubleType,
	enumBooleanType
};

class unionToken {
	public:
		unionToken() : token_type(enumUnknownType) {}
		std::string *&StringType() { token_type = enumStringType; return token_value.string_value; }

		tokenTypeEnum 		token_type;
		union {
			std::string 	*string_value;
			int				integer_value;
			double 			double_value;
			bool			bool_value;
		} token_value;
};

#define  YYSTYPE_IS_DECLARED 1
typedef unionToken YYSTYPE;
