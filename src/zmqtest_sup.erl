-module(zmqtest_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    ZMQContextManager = ?CHILD(zmq_context, worker, []),
    InterDcPub = ?CHILD(inter_dc_pub, worker, []),
    InterDcSub = ?CHILD(inter_dc_sub, worker, [])
    {ok, { {one_for_one, 5, 10}, [InterDcPub, InterDcSub]} }.
