/*GRAMATICA*/
/*Parte Lexica*/
%lex

%options case-sensitive

escapechar				[\'\"\\bfrv]
escape 					{escapechar}
acceptedcharsdouble		[^\"\\]+
tab 					[\t+]
salto					[\n+]
stringdouble 			{escape}|{acceptedcharsdouble}|{tab}
stringliteral			\"{stringdouble}*\"

acceptedsinglechar 		[^\'\\]
stringsingle			{escape}|{acceptedsinglechar}
charliteral 			\'{stringsingle}\'

BSL						"\\".

%s 						comment
%%

"!!".*					/*Ignorar comentario*/
"'''"					this.begin('comment');
<comment>"'''"			this.popState();
<comment>.				/*Ignorar comentario*/
\s+						/*Ignorar espacios*/

{tab}					return 'tab';
"Importar"				return 'importar';
"Inserteza"				return 'inserteza';
"Principal"             return 'principal';
"clr"					return 'crl';
"Double"				return 'doublet';
"Char"					return 'chart';
"Int"					return 'intt';
"String"				return 'stringt';
":"						return 'colon';
","						return 'coma';
"!"						return 'admi';
"true"					return 'truev';
"false"					return 'falsev';
"void"					return 'void';
"+"						return 'mas';
"++"                    return 'masmas';
"*"						return 'por';
"-"						return 'menos';
"--"                    return 'menosmenos';
"/"						return 'div';
"%"						return 'mod';
"^"						return 'pow';
">"						return 'mayor'; 
">="                    return 'mayorigual';
"<"						return 'menor';
"<="                    return 'menorigual';
"~"						return 'virg';
"&"						return 'and';
"&&"                    return 'doubleand';
"|"						return 'or';
"||"                    return 'doubleor'
"("						return 'openpar';
")"						return 'closepar';
"="                     return 'igual';
"=="                    return 'equals';
"!="                    return 'noigual'
"Retorno"				return 'retorno';
"Si"					return 'si';
"Sino"					return 'sino';
"Mostrar"				return 'mostrar';
"Para"					return 'para';
";"						return 'semicolon';
"Mientras"				return 'mientras';
"Detener"				return 'detener';
"Continuar"				return 'continuar';
"DibujarAST"			return 'dibujarast';
"DibujarEXP"			return 'dibujarexp';
"DibujarTS"				return 'dibujarts';
(([0-9]+"."[0-9]*)|("."[0-9]+))     return 'doublevalue';
[0-9]+                              return 'intvalue';

[a-zA-Z_][a-zA-Z0-9_ñÑ]*            return 'identificador';

{stringliteral}                     return 'stringvalue';
{charliteral}                       return 'charvalue';

. {
    console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);
}

<<EOF>>                     return 'EOF'
/lex

//SECCION 

%%	

INICIO:
	BODY EOF
	;
BODY:
	BODY SUB_BODY
	|SUB_BODY
;

SUB_BODY:
	DECLARACION_GLOBAL
	|DECLARACION_VACIA_GLOBAL
    |FUNCION
    |DECLARACION
	|DECLARACION_VACIA
	|ASIGNACION
	|IF_SENTENCE
	|MIENTRAS
	|PARA
	|DIBUJARAST
	|DIBUJAREXP
	|DIBUJARTS
	|MOSTRAR
	|LLAMADA
	|RETURN
;

CICLE_BODY:
	FUNCT_BODY
	|continue
	|detener
;
EXPR:
    PRIMITIVO
    |OP_ARITMETICAS
    |OP_LOGICA
    |OP_RELACIONAL
    |LLAMADA
    |identificador
    |openpar EXPR closepar
    ;

PRIMITIVO:
    intvalue
    |doublevalue
    |stringvalue
    |charvalue
    |true
    |false
    ;

OP_ARITMETICAS: 
    EXPR mas EXPR
    |EXPR menos EXPR
    |EXPR por EXPR
    |EXPR div EXPR
    |EXPR mod EXPR
    |EXPR masmas
    |EXPR menosmenos
    ;

OP_RELACIONALES:
    EXPR equals EXPR
    |EXPR menor EXPR
    |EXPR mayor EXPR
    |EXPR mayorigual EXPR
    |EXPR menorigual EXPR
    |EXPR noigual EXPR
    ;

OP_LOGICAS:
    admi EXPR
    |EXPR doubleand EXPR
    |EXPR doubleor EXPR
    ;
LLAMADA:
    identificador openpar ARG_LIST closepar
    ;

ARG_LIST:
    ARGS
    |
    ;

ARGS:  
    ARGS coma SARG
    |SARG
    ;
/*S de Single xD*/
SARG:
    EXPR
    ;


DECLARACION_VACIA:
    tab TIPO ID_LIST
    ;

ID_LIST:
    ID_LIST coma ID
    ;

ID:
    identificador
    ;
DECLARACION:
    tab TIPO identificador igual EXPR
    ;
ASIGNACION:
    salto identificador igual EXPR
    ;
TIPO:
    intt
    |doublet
    |stringt
    |booleant
    |chart
    |void
;

FUNCION:
    TIPO identificador openpar PARAMS closepar colon salto CLASSBODY
|PRINCIPAL
;
PRINCIPAL:
    void principal openpar PARAMS closepar colon salto FUNCT_BODY
;

RETURN:
	tab retorno EXPR salto
	|tab retorno salto
	
;
PARAMS:
    PARAM_LIST
    |
;

PARAM_LIST:
    PARAM_LIST coma PARAMETRO
;

PARAMETRO:
    PARAM_DECLARATRION
;

PARAM_DECLARATRION:
    TIPO identificador
;
IF:
    tab si openpar EXPR closepar colon salto FUNCT_BODY
;

ELSE:
    tab sino colon salto FUNCT_BODY
;

IF_SENTENCE:
    IF
    |IF ELSE
    ;

PARA:
   tab para openpar FOR_VAR semicolon EXPR semicolon OP closepar colon salto CICLE_BODY

;

FOR_VAR:
    DECLARACION
    |ASIGNACION
;

OP:
    masmas
    |menosmenos
;

MIENTRAS:
	tab mientras openpar EXPR closepar colon salto CICLE_BODY 
;

MOSTRAR:
	tab openpar SOUT_BODY closepar salto
;

SOUT_BODY:
	EXPR coma SOUT_BODY
	|EXPR
;


DIBUJARAST:
	tab dibujarast openpar identificador closepar salto
;

DIBUJAREXP:
	tab dibujarexp openpar EXPR closepar salto
;

DIBUJARTS:
	tab dibujarts openpar closepar salto
	
;
