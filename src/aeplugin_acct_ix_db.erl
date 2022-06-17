%%% -*- erlang-indent-level:4; indent-tabs-mode: nil -*-
-module(aeplugin_acct_ix_db).
-export([ add_index_plugins/1
	, add_indexes/1 ]).

%% Indexing callbacks
-export([ f_accts/3 ]).

-define(IX_ACCOUNTS, aeplugin_tx_accounts).

%% Register an index plugin so we can define our own index type,
%% and give it a unique name.
add_index_plugins(_Mode) ->
    mnesia_schema:add_index_plugin({?IX_ACCOUNTS}, ?MODULE, f_accts).

%% Since we use an index plugin with a unique name, there
%% should be no risk of an index name conflict.
add_indexes(_Mode) ->
    mnesia:add_table_index(aec_signed_tx, {?IX_ACCOUNTS}).

%% This is the indexing callback.
%% We're not allowed to include hrls from the AE node, so we
%% rely on exported `exprecs` accessors.
f_accts(_Tab, _Pos, Obj) ->
    case aec_db:'#is_record-'(aec_signed_tx, Obj) of
        true ->
            STx = aec_db:'#get-aec_signed_tx'(val, Obj),
            Tx = aetx_sign:tx(STx),
            aetx:accounts(Tx);
        false ->
            []
    end.
