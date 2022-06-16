-module(aeplugin_acct_ix_app).
-behavior(application).

-export([ start/2
	, start_phase/3
	, stop/1 ]).

-define(PLUGIN_NAME_STR, <<"aeplugin_acct_ix">>).
-define(SCHEMA_FNAME, "aeplugin_acct_ix_schema.json").
-define(OS_ENV_PFX, "ACCT_IX").

start(_Type, _Args) ->
    aeplugin_acct_ix_sup:start_link().

start_phase(_Phase, _Type, _Args) ->
    ok.

stop(_State) ->
    ok.
