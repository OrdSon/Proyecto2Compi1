/*GRAMATICA*/
/*Parte Lexica*/
%lex

%options case-sensitive

escapechar				[\'\"\\bf]
escape 					{escapechar}
acceptedcharsdouble		[^\"\\]+
tab 					[\t]+
saltos                  [\n|\r|\v]+

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

{tab}					return 'tab';
{saltos}                return 'salto';
\s+						/*Ignorar espacios*/
\n+                     return 'salto';
"Importar"				return 'importar';
"Incerteza"				return 'incerteza';
"Principal"             return 'principal';
"clr"					return 'crl';
"Double"				return 'doublet';
"Char"					return 'chart';
"Int"					return 'intt';
"String"				return 'stringt';
"Boolean"               return 'booleant'
"!&"                    return 'notand';
"!="                    return 'noigual'
"=="                    return 'equals';
"<="                    return 'menorigual';
">="                    return 'mayorigual';
"&&"                    return 'doubleand';
"||"                    return 'doubleor'
"++"                    return 'masmas';
"--"                    return 'menosmenos';
":"						return 'colon';
","						return 'coma';
"!"						return 'admi';
"true"					return 'truev';
"false"					return 'falsev';
"Void"					return 'void';
"+"						return 'mas';
"*"						return 'por';
"-"						return 'menos';
"/"						return 'div';
"%"						return 'mod';
"^"						return 'pow';
">"						return 'mayor'; 
"<"						return 'menor';
"~"						return 'virg';
"("                     return 'openpar';
")"						return 'closepar';
"="                     return 'igual';
"Retorno"				return 'retorno';
"Si"					return 'si';
"Sino"					return 'sino';
"Para"					return 'para';
";"						return 'semicolon';
"Mientras"				return 'mientras';
"Detener"				return 'detener';
"Continuar"				return 'continuar';
"crl"                   return 'crl';
"."                     return 'dot';
\"[^\"]*\"              { yytext = yytext.substr(1,yyleng-2); return 'stringvalue'; }
(([0-9]+"."[0-9]*)|("."[0-9]+))     return 'doublevalue';
[0-9]+                              return 'intvalue';

[a-zA-Z_][a-zA-Z0-9_ñÑ]*            return 'identificador';

{charliteral}                       return 'charvalue';

. {
    console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);
}

<<EOF>>                     return 'EOF'
/lex

//SECCION 
%right 'coma'
%left 'doubleor'
%left 'and'
%left 'menor' 'menorigual' 'mayor' 'mayorigual' 'igual' 'noigual'
%left 'mas' 'menos'
%left 'por''div' 'mod'
%left 'admi'
%right 'masmas' 'menosmenos'
%left UNMINUS
%left 'openpar' 'closepar'

%start INICIO
%%	

INICIO:
	BODY EOF
	;
BODY:
	BODY SUB_BODY
	|SUB_BODY
;
SUB_BODY:
    DECLARACION salto
	|ASIGNACION salto
	|IF salto
    |ELSE salto
	|MIENTRAS salto
	|PARA salto
	|LLAMADA salto
	|RETURN salto
    |FUNCION salto
    |tab continuar salto
    |tab detener salto
    |INCERTEZA
    |IMPORT
    |salto
;

CICLE_BODY:
	FUNCT_BODY
	|continue
	|detener
;
EXPR:
    PRIMITIVO
    |OP_ARITMETICAS
    |LLAMADA
    |identificador{console.log($1);}
    |openpar EXPR closepar
    ;

PRIMITIVO:
    intvalue {console.log($1);}
    |doublevalue {console.log($1);}
    |stringvalue {console.log($1);}
    |charvalue {console.log($1);}
    |truev {console.log($1);}
    |falsev {console.log($1);}
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

RELACIONES:
    OP_RELACIONALES
    |OP_LOGICAS
;
OP_RELACIONALES:
    EXPR equals EXPR
    |EXPR menor EXPR
    |EXPR mayor EXPR
    |EXPR mayorigual EXPR
    |EXPR menorigual EXPR
    |EXPR noigual EXPR
    |EXPR virg EXPR
    ;

OP_LOGICAS:
    admi EXPR
    |EXPR doubleand EXPR
    |EXPR doubleor EXPR
    |EXPR notand EXPR
    ;
LLAMADA:
    identificador openpar ARG_LIST closepar
    |tab identificador openpar ARG_LIST closepar
    |identificador openpar  closepar
    ;

ARG_LIST:
    ARGS
    ;

ARGS:  
    ARGS coma SARG
    |SARG
    ;
/*S de Single xD*/
SARG:
    EXPR
    |RELACIONES
    ;
DECLARACION_VACIA:
    tab TIPO ID_LIST 
    ;

ID_LIST:
    ID_LIST coma ID
    ;

ID:
    identificador {console.log($1);}
    ;
DECLARACION:
    tab TIPO identificador igual EXPR {console.log($3);}
    |TIPO identificador igual EXPR {console.log($2);}
    |DECLARACION_VACIA
    ;
ASIGNACION:
    tab identificador igual EXPR {console.log($2);}
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
    TIPO identificador openpar PARAMS closepar colon  {console.log($2);}
    |TIPO identificador openpar  closepar colon {console.log($2);}
|PRINCIPAL
;
PRINCIPAL:
    void principal openpar PARAMS closepar colon{console.log($2);}
    |void principal openpar  closepar colon
;
RETURN:
	tab retorno EXPR 
	|tab retorno 
	
;
PARAMS:
    PARAM_LIST
;

PARAM_LIST:
    PARAM_LIST coma PARAMETRO
    |PARAMETRO
;

PARAMETRO:
    TIPO identificador
;


IF:
    tab si openpar RELACIONES closepar colon 
;

ELSE:
    tab sino colon 
;


PARA:
   tab para openpar FOR_VAR semicolon RELACIONES semicolon OP closepar colon 

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
	tab mientras openpar RELACIONES closepar colon 
;

IMPORT:
    importar identificador dot crl salto
;

INCERTEZA:
    incerteza doublevalue salto
;
