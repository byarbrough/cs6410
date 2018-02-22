structure Types =
struct

  type unique = unit ref

  datatype ty = 
            RECORD of (Symbol.symbol * ty) list * unique
          | NIL
          | INT
          | STRING
          | ARRAY of ty * unique
	      | NAME of Symbol.symbol * ty option ref
	      | UNIT
  fun toString( RECORD(list, unique)) = "RECORD"
  	| toString(NIL) = "NIL"
  	| toString(INT) = "INT"
  	| toString(STRING) = "STRING"
  	| toString(ARRAY(ty, unique)) = "Array of " ^ toString(ty)
  	| toString(NAME(symbol, ty)) = "NAME of " ^ toString(getOpt(!ty, NIL))
  	| toString(UNIT) = "UNIT"
end

