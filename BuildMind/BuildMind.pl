:- dynamic
% Static Percepts
	base/4,
	baseCenter/3,
	chokepoint/6,

% Dynamic Percepts
	constructionSite/4,
	mineralField/4,
	vespeneGeyser/4,
	gameframe/1,
	
% BuildMind beliefs
	buildRequest/3,
	buildTarget/4,
	ownMain/3,
	ownNatural/3,
	ownBase/3,
	baseIsDangerous/3,
	enemyBase/3
.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% GENERIC FUNCTIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate distance between two points
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points
distanceSq(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

% Concatenate a list of atoms
atomic_list_concat([], '').
atomic_list_concat([H|T], Result) :- atomic_list_concat(T, Remainder), atom_concat(H, Remainder, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% WORKER FUNCTIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determines a valid construction site based on the building
getValidConstructionSite(Agent, X1, Y1, RegionId, Thing) :- metrics(Thing, Width, Height, _, _), getValidConstructionSite(Agent, X1, Y1, RegionId, Width, Height).
% Determines a valid construction site based on the dimensions
getValidConstructionSite(Agent, X1, Y1, RegionId, 2, 2) :- constructionSite(X1, Y1, RegionId, true),
	not((buildTarget(OtherAgent, X1, Y1, RegionId), Agent \= OtherAgent)),
	not(creepColonyBlocked(X1, Y1, RegionId)).
getValidConstructionSite(Agent, X1, Y1, RegionId, Width, 2) :- Width > 2, constructionSite(X1, Y1, RegionId, true),
	not((buildTarget(OtherAgent, X1, Y1, RegionId), Agent \= OtherAgent)),
	not(constructionSiteBlocked(X1, Y1, RegionId)),
	X2 is X1 + 2, constructionSite(X2, Y1, RegionId, true).
getValidConstructionSite(Agent, X1, Y1, RegionId, 2, Height) :- Height > 2, constructionSite(X1, Y1, RegionId, true),
	not((buildTarget(OtherAgent, X1, Y1, RegionId), Agent \= OtherAgent)),
	not(constructionSiteBlocked(X1, Y1, RegionId)),
	Y2 is Y1 + 2, constructionSite(X1, Y2, RegionId, true).
getValidConstructionSite(Agent, X1, Y1, RegionId, Width, Height) :- Width > 2, Height > 2,
	not((buildTarget(OtherAgent, X1, Y1, RegionId), Agent \= OtherAgent)),
	constructionSite(X1, Y1, RegionId, _), not(nearbyResources(X1, Y1)),
	X2 is X1 + 2, constructionSite(X2, Y1, _, _), not(nearbyResources(X2, Y1)),
	Y2 is Y1 + 2, constructionSite(X1, Y2, _, _), not(nearbyResources(X1, Y2)),
	constructionSite(X2, Y2, _, _), not(nearbyResources(X2, Y2)).
	
constructionSiteBlocked(X1, Y1, RegionId) :-
	baseCenter(X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12), D12 < 81,
	((mineralField(_, X3, Y3, RegionId), distanceSq(X1, Y1, X3, Y3, D13), D13 < 36)
	;
	(vespeneGeyser(_, X4, Y4, RegionId), distanceSq(X1, Y1, X4, Y4, D14), D14 < 36)).
	
creepColonyBlocked(X1, Y1, RegionId) :-
	baseCenter(X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12), D12 < 64,
	mineralField(_, X3, Y3, RegionId), distanceSq(X1, Y1, X3, Y3, D13), D13 < 25.

nearbyResources(X1, Y1) :- 
	(mineralField(_, X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12), D12 < 49) ;
	(vespeneGeyser(_, X3, Y3, RegionId), distanceSq(X1, Y1, X3, Y3, D13), D13 < 49).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% METRICS (KNOWLEDGE.PL) %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
metrics('Zerg Hatchery',4,3,9,0).
metrics('Zerg Nydus Canal',2,2,8,0).
metrics('Zerg Hydralisk Den',3,2,8,0).
metrics('Zerg Defiler Mound',4,2,8,0).
metrics('Zerg Queens Nest',3,2,8,0).
metrics('Zerg Evolution Chamber',3,2,8,0).
metrics('Zerg Ultralisk Cavern',3,2,8,0).
metrics('Zerg Spire',2,2,8,0).
metrics('Zerg Spawning Pool',3,2,8,0).
metrics('Zerg Creep Colony',2,2,10,0).
