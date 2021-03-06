%% eggs (Erlang Generic Game Server)
%%
%% Copyright (C) 2012-2013  Jordi Llonch <llonch.jordi at gmail dot com>
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Affero General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details.
%%
%% You should have received a copy of the GNU Affero General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

-module(example_game_world).
-behaviour(eggs_world_simple_area).

%% API
-export([initialize/1, destroy/1]).
-export([frozen/2, running/2, run/1, froze/1, stop/1]).
-export([get/2, set/2, set/3, entity_add/3, entity_remove/2, entity_move/3, entity_add_handler/3, entity_remove_handler/3, get_entities_list/1]).

-spec initialize({_,_}) -> {'ok',_}.
initialize({GameServerPid, WorldSupPid}) ->
  AreaSpecs = [{x, 0}, {y, 0}, {width, 1000}, {height, 1000}],
  {ok, WorldEntity} = eggs_world_simple_area:initialize({GameServerPid, WorldSupPid, ?MODULE, AreaSpecs}),
  {ok, WorldEntity}.

-spec destroy(_) -> any().
destroy(World) ->
  eggs_world_simple_area:destroy(World).

-spec run(_) -> any().
run(World) ->
  eggs_world_simple_area:run(World).
-spec froze(_) -> any().
froze(World) ->
  eggs_world_simple_area:froze(World).

-spec frozen({_,_},_) -> {'next_state','frozen',_}.
frozen({_Event, _Message}, World) ->
  {next_state, frozen, World}.

-spec running({_,_},_) -> {'next_state','running',_}.
running({_Event, _Message}, World) ->
  {next_state, running, World}.

%% entity
-spec get(_,_) -> any().
get(World, Property) ->
  eggs_world_simple_area:get(World, Property).
-spec set(_,_) -> any().
set(World, Values) ->
  eggs_world_simple_area:set(World, Values).
-spec set(_,_,_) -> any().
set(World, Property, Value) ->
  eggs_world_simple_area:set(World, Property, Value).

-spec entity_add(_,_,_) -> any().
entity_add(World, Entity, Coords) ->
  eggs_world_simple_area:entity_add(World, Entity, Coords).

-spec entity_remove(_,_) -> any().
entity_remove(World, Entity) ->
  eggs_world_simple_area:entity_remove(World, Entity).

-spec entity_move(_,_,_) -> any().
entity_move(World, Entity, Coords) ->
  eggs_world_simple_area:entity_move(World, Entity, Coords).

-spec entity_add_handler(_,_,_) -> any().
entity_add_handler(World, Entity, Handler) ->
  eggs_world_simple_area:entity_add_handler(World, Entity, Handler).

-spec entity_remove_handler(_,_,_) -> any().
entity_remove_handler(World, Entity, Handler) ->
  eggs_world_simple_area:entity_remove_handler(World, Entity, Handler).

-spec get_entities_list(_) -> any().
get_entities_list(World) ->
  eggs_world_simple_area:get_entities_list(World).

-spec stop(_) -> 'ok'.
stop(_World) -> ok.

%% %% API
%% -export([initialize/1, initialize/2, is_active/0, get/2, set/2, set/3, frozen/2]).
%% 
%% initialize(GameServerPid) ->
%%   eggs_world:initialize({GameServerPid, ?MODULE}).
%% 
%% 
%% %% entity
%% initialize(_, _) ->
%%   initialize(none).
%% initialize(_) ->
%%   %% entity
%%   WorldEntityInit = eggs_entity:initialize(?MODULE, [{width, 1000},
%%                                                      {height, 1000},
%%                                                      {split_width, 10},
%%                                                      {split_height, 10}]),
%%   %% trait active
%%   WorldEntity = eggs_trait_world:initialize(?MODULE, WorldEntityInit, frozen),
%%   WorldEntity.
%% 
%% is_active() -> true.
%% 
%% get(World, Property) ->
%%   eggs_entity:base_get(World, Property).
%% 
%% set(World, Values) ->
%%   eggs_entity:base_set(World, Values).
%% set(World, Property, Value) ->
%%   eggs_entity:base_set(World, Property, Value).
%% 
%% %% trait active handlers
%% frozen(Message, World) ->
%%   lager:debug("World frozen: ~p", [Message]),
%%   {next_state, frozen, World}.


