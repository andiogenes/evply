package interpreter;

import editor.workspace.Node;

enum ASTType {
    ANumber(number: Float);
    AString(string: String);
    ASymbol(string: String);
    ABoolean(boolean: Bool);
    APicture(x: Int, y: Int);
    AList(list: List<ASTType>);
    ALambda;
    AQuote;
    AIf;
    ADef;
    AListSymbol;
    ABegin;
}

typedef Scope = {
    var definitions: Map<ASTType, Dynamic>;
    var outer: Null<Scope>;
}

class Evaluator {
    public var globalScope(default, null): Scope = {
        definitions: [
            ASymbol("") => ""
        ],
        outer: null
    };

    static function makeScope(_outer: Scope): Scope {
        return {definitions: new Map<ASTType, Dynamic>(), outer: _outer};
    }

    static function define(scope: Scope, key: ASTType, value: Dynamic) {
        scope.definitions.set(key, value);
    }

    static function hasKey(scope: Scope, key: ASTType): Bool {
        return scope.definitions.exists(key);
    }

    static function getValue(scope: Scope, key: ASTType): Dynamic {
        return scope.definitions.get(key);
    }

    static function findInScopes(scope: Scope, key: ASTType): Dynamic {
        var ret = null;
        ret = getValue(scope, key);
        if (ret != null || scope.outer == null) {
            return ret;
        }

        ret = findInScopes(scope.outer, key);
        return ret;
    }

    public function new() {

    }

    public function eval(expr: ASTType, scope: Scope): Null<ASTType> {
        var out = switch (expr) {
            case ANumber(_) | AString(_) | ASymbol(_) | ABoolean(_) | APicture(_,_):
                expr;
            case AList(list):
                var head = list.pop();
                var tail = list;
                var lOut = switch (head) {
                    case ADef:
                        var tailHead = tail.pop();
                        var value = eval(tail.first(), scope);

                        switch (tailHead) {
                            case ASymbol(_):
                                define(scope, tailHead, value);
                            case _:
                                var reduced = eval(tailHead, scope);
                                if (reduced.match(ASymbol(_)))
                                    define(scope, reduced, value);
                        }
                        null;
                    case ALambda:
                        var args = tail.pop();
                        var body = tail.first();

                        if (args.match(AList(_)) && body.match(AList(_))) {
                            var localScope = makeScope(scope);
                            null;
                        } else {
                            null;
                        }
                    case AIf:
                        null;
                    case AQuote:
                        null;
                    case AListSymbol:
                        null;
                    case ABegin:
                        null;
                    case _:
                        null;
                }

                lOut;
            case _:
                null;
        }

        return out;
    }

    public function objectize(expr: Null<ASTType>): Null<RealType> {
        var out = switch(expr) {
            case ANumber(number):
                RNumber(number);
            case AString(string):
                RString(string);
            case ASymbol(string):
                RSymbol(string);
            case ABoolean(boolean):
                RBoolean(boolean);
            case APicture(x, y):
                RPicture(x, y);
            case AList(list):
                null;
            case ALambda:
                RLambdaSymbol;
            case AQuote:
                RQuoteSymbol;
            case AIf:
                RIfSymbol;
            case ADef:
                RDefSymbol;
            case AListSymbol:
                RListSymbol;
            case ABegin:
                RBegin;
            case _:
                null;
        }

        return out;
    }
}