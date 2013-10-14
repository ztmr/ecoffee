-module (ecoffee).
-export ([start/0, stop/0, compile/1]).

%% The name of the app is the same as our module
-define (APPNAME, ?MODULE).
-define (COFFEE_ENGINE_SOURCE_FILENAME, "coffee-script.js").

start () -> application:start (?APPNAME).
stop () -> application:stop (?APPNAME).

%% XXX: this is not so good, we should rather manage a pool
%% of compile processes holding the context
-spec compile (CoffeeSourceData::binary ()) -> JavaScriptSource::binary ().
compile (CoffeeSourceData) when is_binary (CoffeeSourceData) ->
    {ok, CoffeeScriptEngine} = compiler_source_lib (),
    {ok, JSRuntime}          = js_driver:new (),
    ok = js:define (JSRuntime, CoffeeScriptEngine),
    Result = js:call (JSRuntime, <<"CoffeeScript.compile">>, [CoffeeSourceData]),
    js_driver:destroy (JSRuntime),
    Result.

compiler_source_lib () ->
    F = filename:join ([ priv_dir (),
                         ?COFFEE_ENGINE_SOURCE_FILENAME ]),
    file:read_file (F).

priv_dir () ->
    case code:priv_dir (?APPNAME) of
        {error, _} -> "priv";
        Directory  -> Directory
    end.
