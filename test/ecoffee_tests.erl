-module (ecoffee_tests).

-include_lib ("eunit/include/eunit.hrl").

ecoffee_test_ () ->
    {setup,
     fun () ->
             application:start (sasl),
             application:start (erlang_js),
             application:start (ecoffee),
             ok
     end,
     fun (_) ->
             application:stop (ecoffee),
             application:stop (erlang_js),
             application:stop (sasl),
             ok
     end,
     [{"ecoffee is alive",
       fun () ->
               [ ?assertEqual ({ok,<<"(function() {\n  console.log('hello!');\n\n}).call(this);\n">>},
                               ecoffee:compile (<<"console.log 'hello!'">>))
                 || _ <- lists:seq (1, 10) ]
       end}]}.

