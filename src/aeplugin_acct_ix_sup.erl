-module(aeplugin_acct_ix_sup).
-behavior(supervisor).

-export([ start_link/0 ]).

-export([ init/1 ]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    SupFlags = #{ strategy  => one_for_one
		, intensity => 3
		, period    => 60 },
    {ok, SupFlags, []}.
