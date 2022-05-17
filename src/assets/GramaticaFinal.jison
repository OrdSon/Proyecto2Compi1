/*GRAMATICA*/
/*Parte Lexica*/
%{
let Instrucciones = [];    
%}
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
%{
    const {Declaracion} = require("../Instrucciones/Declaracion.ts");
    const {Asignacion} = require("../Instrucciones/Asignacion.ts");
    const {Identificador} = require("../Instrucciones/Identificador.ts");
    const {Funcion} = require("../Instrucciones/Funcion.ts");
    const {Llamada} = require("../Instrucciones/Llamada.ts");
    const {Operacion} = require("../Instrucciones/Operacion.ts");
    const {Primitivo} = require("../Instrucciones/Primitivo.ts");//ya
    const {Tipo} = require("../Enums/Tipo.ts");
    const {Operador} = require("../Enums/Operador.ts");
    const {If} = require("../Instrucciones/If.ts");
    const {Else} = require("../Instrucciones/Else.ts");
    const {For} = require("../Instrucciones/For.ts");
    const {While} = require("../Instrucciones/While.ts");
    const {Incerteza} = require("../Instrucciones/Incerteza.ts");
    const {Import} = require("../Instrucciones/Import.ts");
    const {Retorno} = require("../Instrucciones/Retorno.ts");
    const {Continuar} = require("../Instrucciones/Continuar.ts");
    const {Detener} = require("../Instrucciones/Detener.ts");


    %}
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
	BODY EOF {$$=$1; return $$;}
	;
BODY:
	BODY SUB_BODY{$1.push($2); $$ = $1;}
	|SUB_BODY{$$=[$1];}
;
SUB_BODY:
    DECLARACION salto {$$=$1;} //parcialmente listo, falta PUSH
	|ASIGNACION salto {$$=$1;} //parcialmente listo, falta PUSH
	|IF salto {$$=$1;} ////parcialmente listo, falta PUSH
    |ELSE salto {$$=$1;}////parcialmente listo, falta PUSH
	|MIENTRAS salto {$$=$1;}////parcialmente listo, falta PUSH
	|PARA salto {$$=$1;}////parcialmente listo, falta PUSH
	|LLAMADA salto {$$=$1;}////parcialmente listo, falta PUSH
	|RETURN salto {$$=$1;}////parcialmente listo, falta PUSH
    |FUNCION salto {$$=$1;}  //parcialmente listo, falta PUSH
    |tab continuar salto {$$ = new Continuar(@1.first_line,@1.first_column,$1);}
    |tab detener salto{$$=new Detener(@1.first_line,@1.first_column,$1);}
    |INCERTEZA {$$=$1;}//parcialmente listo, falta PUSH
    |IMPORT {$$=$1;}//parcialmente listo, falta PUSH
    |salto
;

CICLE_BODY:
	FUNCT_BODY
	|continue
	|detener
;

EXPR:
    PRIMITIVO {$$=$1}
    |OP_ARITMETICAS {$$=$1}
    |LLAMADA {$$=$1}
    |identificador{$$=new Identificador(@1.first_line,@1.first_column,$1,"");}
    |openpar EXPR closepar {$$=$2}
    ;

PRIMITIVO:
    intvalue {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.INT,"");}
    |doublevalue {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.DOUBLE,"");}
    |stringvalue {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.STRING,"");}
    |charvalue {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.CHAR,"");}
    |truev {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.BOOLEAN,"");}
    |falsev {$$=new Primitivo(@1.first_line,@1.first_column,$1,Tipo.BOOLEAN,"");}
;

OP_ARITMETICAS: 
    EXPR mas EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MAS,"");}
    |EXPR menos EXPR{$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MENOS,"");}
    |EXPR por EXPR{$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.POR,"");}
    |EXPR div EXPR{$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.DIV,"");}
    |EXPR mod EXPR{$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MOD,"");}
    |EXPR masmas{$$ = new Operacion(@1.first_line,@1.first_column,$1,null,Operador.INCREMENTO,"");}
    |EXPR menosmenos{$$ = new Operacion(@1.first_line,@1.first_column,$1,null,Operador.DECREMENTO,"");}
    ;

RELACIONES:
    OP_RELACIONALES {$$ = $1;}
    |OP_LOGICAS {$$=$1;}
;
OP_RELACIONALES:
    EXPR equals EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.EQUALS,"");}
    |EXPR menor EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MENOR,"");}
    |EXPR mayor EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MAYOR,"");}
    |EXPR mayorigual EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MAYORIGUAL,"");}
    |EXPR menorigual EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.MENORIGUAL,"");}
    |EXPR noigual EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.NOTEQUAL,"");}
    |EXPR virg EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.VIRG,"");}
    ;

OP_LOGICAS:
    admi EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,null,Operador.NOT,"");}
    |EXPR doubleand EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.AND,"");}
    |EXPR doubleor EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.OR,"");}
    |EXPR notand EXPR {$$ = new Operacion(@1.first_line,@1.first_column,$1,$3,Operador.XOR,"");}
    ;
LLAMADA:
    identificador openpar ARG_LIST closepar {$$=new Llamada(@1.first_line,@1.first_column,$1,$3,"");}
    |tab identificador openpar ARG_LIST closepar {$$=new Llamada(@1.first_line,@1.first_column,$2,$4,$1);}
    |identificador openpar  closepar {$$=new Llamada(@1.first_line,@1.first_column,$1,null,"");}
    ;

ARG_LIST:
    ARGS {$$=$1;}
    ;

ARGS:  
    ARGS coma SARG {$1.push($3); $$ = $1;}
    |SARG{$$ = [$1];}
    ;
/*S de Single xD*/
SARG:
    EXPR {$$=$1;}
    |RELACIONES {$$=$1;}
    ;
DECLARACION_VACIA:
    tab TIPO ID_LIST {$$ = new Declaracion(null,null,$2,$3,@1.first_line,@1.first_column,$1);}
    ;

ID_LIST:
    ID_LIST coma ID {$1.push($3); $$ = $1;}
    |ID{$$=[$1];}
    ;

ID:
    identificador {$$ = $1;}
    ;
DECLARACION:
    tab TIPO identificador igual EXPR {$$=new Declaracion($3,$5,$2,null,@1.first_line,@1.first_column,$1);}
    |TIPO identificador igual EXPR {$$=new Declaracion($2,$4,$1,null,@1.first_line,@1.first_column,"");}
    |DECLARACION_VACIA
    ;
ASIGNACION:
    tab identificador igual EXPR {$$=new Asignacion(@1.first_line,@1.first_column,$4,$2,$1);}
    ;
TIPO:
    intt{$$ = Tipo.INT;}
    |doublet{$$ = Tipo.DOUBLE;}
    |stringt{$$ = Tipo.STRING;}
    |booleant{$$ = Tipo.BOOLEAN;}
    |chart{$$ = Tipo.CHAR;}
    |void{$$ = Tipo.VOID;}
;
FUNCION:
    TIPO identificador openpar PARAMS closepar colon  {$$=new Funcion(@1.first_line,@1.first_column,$2,$4,$1,"");}
    |TIPO identificador openpar  closepar colon  {$$=new Funcion(@1.first_line,@1.first_column,$2,null,$1,"");}
|PRINCIPAL
;
PRINCIPAL:
    void principal openpar PARAMS closepar colon{$$=new Funcion(@1.first_line,@1.first_column,$2,$4,Tipo.VOID,"");}
    |void principal openpar  closepar colon{$$=new Funcion(@1.first_line,@1.first_column,$2,null,Tipo.VOID,"");}
;
RETURN:
	tab retorno EXPR {$$=new Retorno(@1.first_line,@1.first_column,$3,$1);}
	|tab retorno {$$=new Retorno(@1.first_line,@1.first_column,$3,null);}
	
;
PARAMS:
    PARAM_LIST {$$=$1}
;

PARAM_LIST:
    PARAM_LIST coma PARAMETRO {$1.push($3); $$=$1;}
    |PARAMETRO {$$=[$1];}
;

PARAMETRO:
    TIPO identificador{$$ = new Declaracion($2,null,$1,null,@1.first_line,@1.first_column,"");}
;


IF:
    tab si openpar RELACIONES closepar colon {$$ = new If(@1.first_line,@1.first_column,$4,$1);}
;

ELSE:
    tab sino colon {$$ = new Else(@1.first_line,@1.first_column,$1);}
;


PARA:
   tab para openpar FOR_VAR semicolon RELACIONES semicolon OP closepar colon {$$ = new For(@1.first_line,@1.first_column,$4,$6,$8,$1);}

;

FOR_VAR:
    DECLARACION {$$=$1;}
    |ASIGNACION {$$=$1;}
;

OP:
    masmas {$$ = Operador.INCREMENTO;}
    |menosmenos {$$ = Operador.DECREMENTO}
;
MIENTRAS:
	tab mientras openpar RELACIONES closepar colon {$$= new While(@1.first_line,@1.first_column,$4,$1);}
    ;

IMPORT:
    importar identificador dot crl salto {$$ = new Import(@1.first_line,@1.first_column,$2,"");}
;

INCERTEZA:
    incerteza doublevalue salto {$$=new Incerteza(@1.first_line,@1.first_column,$2,"");}
;
