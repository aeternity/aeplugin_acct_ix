%%% -*- erlang-indent-level:4; indent-tabs-mode: nil -*-
-module(aeplugin_acct_ix_db).
-export([ add_index_plugins/1
	, add_indexes/1 ]).

%% Indexing callbacks
-export([ f_accts/1 ]).

-include_lib("aecore/include/aec_db.hrl").

-define(IX_ACCOUNTS, aeplugin_tx_accounts).


add_index_plugins(_Mode) ->
    mnesia_schema:add_index_plugin({?IX_ACCOUNTS}, ?MODULE, f_accts).

add_indexes(_Mode) ->
    mnesia:add_table_index(aec_signed_tx, {?IX_ACCOUNTS}).

f_accts(#aec_signed_tx{value = STx}) ->
    Tx = aetx_sign:tx(STx),
    aetx:accounts(Tx).
