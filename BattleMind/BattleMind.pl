:- dynamic
% Static Percepts
	base/6,
	chokepoint/6,
	enemyRace/1,
	region/5,

% Dynamic Percepts
	enemy/7,
	friendly/4,
	gameframe/1,
	resources/1,
	simDisabled/0,
	
% Base Beliefs
	ownMain/3,
	ownNatural/3,
	ownBase/3,
	enemyBase/3,
	baseIsDangerous/3,
	regionUnderAttack/1,

% Global Beliefs
	openingUsed/1,
	currentStrategy/1,
	
% Spotting Beliefs
	vultureSpotted/0,
	siegeTankSpotted/0,
	carrierSpotted/0,
	
% Navigation Beliefs
	toEnemyWaypoint/3,
	toFriendlyWaypoint/3,
	chokepointBlocked/2,
	
% General Beliefs
	task/2,

% Commander Beliefs
	enemySim/6,
	friendlySim/6,
	regionOrder/3
.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% GENERIC FUNCTIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate distance between two points
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points, but do not root it (faster)
distanceSq(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

% Concatenate a list of atoms
atomic_list_concat([], '').
atomic_list_concat([H|T], Result) :- atomic_list_concat(T, Remainder), atom_concat(H, Remainder, Result).

% Retrieves all elements different between two lists
listDifference(L1, L2, Remainder) :- subtract(L1, L2, R1), subtract(L2, L1, R2), append(R1, R2, Remainder).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% GENERAL FUNCTIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attack expansions first
nextAttackLocation(X2, Y2, RegionId) :- ownMain(X1, Y1, _),
	enemyBase(X2, Y2, RegionId), base(false, _, _, X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12),
	not((enemyBase(X3, Y3, _), base(false, _, _, X3, Y3, _), distanceSq(X1, Y1, X3, Y3, D13), D13 < D12)).
% Attack main base second
nextAttackLocation(X2, Y2, RegionId) :- ownMain(X1, Y1, _),
	enemyBase(X2, Y2, RegionId), base(true, _, _, X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12),
	not((enemyBase(X3, Y3, _), base(true, _, _, X3, Y3, _), distanceSq(X1, Y1, X3, Y3, D13), D13 < D12)).
% Attack area's where Overlords died last (potential enemy area's)
nextAttackLocation(X2, Y2, RegionId) :- ownMain(X1, Y1, _),
	baseIsDangerous(X2, Y2, RegionId), distanceSq(X1, Y1, X2, Y2, D12),
	not((baseIsDangerous(X3, Y3, RegionId), distanceSq(X1, Y1, X3, Y3, D13), D13 < D12)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% COMMANDER FUNCTIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
 * Adds the simulator values based on the type
 */
addSim(Type, Vitality, GH, OAH, OGD, OAD, OBD, GH, NAH, NGD, NAD, NBD) :-
	isFlyingUnit(Type), combat(Type, GroundDmg, AirDmg, _, _, _), NAH is OAH + Vitality,
	((GroundDmg > 0, AirDmg > 0) ->
	(NGD is OGD, NAD is OAD, NBD is OBD + (GroundDmg + AirDmg) / 2) ; 
	(NGD is OGD + GroundDmg, NAD is OAD + AirDmg, NBD is OBD)).
addSim(Type, Vitality, OGH, AH, OGD, OAD, OBD, NGH, AH, NGD, NAD, NBD) :-
	not(isFlyingUnit(Type)), combat(Type, GroundDmg, AirDmg, _, _, _), NGH is OGH + Vitality,
	((GroundDmg > 0, AirDmg > 0) ->
	(NGD is OGD, NAD is OAD, NBD is OBD + (GroundDmg + AirDmg) / 2) ; 
	(NGD is OGD + GroundDmg, NAD is OAD + AirDmg, NBD is OBD)).
	
/*
 * Removes the simulator values based on the type
 */
removeSim(Type, Vitality, GH, OAH, OGD, OAD, OBD, GH, NAH, NGD, NAD, NBD) :-
	isFlyingUnit(Type), combat(Type, GroundDmg, AirDmg, _, _, _), NAH is OAH - Vitality,
	((GroundDmg > 0, AirDmg > 0) ->
	(NGD is OGD, NAD is OAD, NBD is OBD - (GroundDmg + AirDmg) / 2) ; 
	(NGD is OGD - GroundDmg, NAD is OAD - AirDmg, NBD is OBD)).
removeSim(Type, Vitality, OGH, AH, OGD, OAD, OBD, NGH, AH, NGD, NAD, NBD) :-
	not(isFlyingUnit(Type)), combat(Type, GroundDmg, AirDmg, _, _, _), NGH is OGH - Vitality,
	((GroundDmg > 0, AirDmg > 0) ->
	(NGD is OGD, NAD is OAD, NBD is OBD - (GroundDmg + AirDmg) / 2) ; 
	(NGD is OGD - GroundDmg, NAD is OAD - AirDmg, NBD is OBD)).
	
/*
 * Determines if this unit is in a winning position in a fight .
 */
%combatSim(Source, FHealth, FRemainder, EHealth, ERemainder) :-
%	toEnemyWaypoint(Source, Target, _), toEnemyWaypoint(Target, TargetTarget, _), TargetTarget \= null,
%	region(Source, _, _, _, Connections),
%	aggregateFriendlySim([Source, TargetTarget | Connections], FGH, FAH, FGD, FAD, FBD),
%	aggregateEnemySim([Source, TargetTarget, 0 | Connections], EGH, EAH, EGD, EAD, EBD), !,
%	combatSimulation(FGH, FAH, FGD, FAD, FBD,
%			 EGH, EAH, EGD, EAD, EBD,
%			 FRemainder, ERemainder, 0),
%	FHealth is FGH + FAH, EHealth is EGH + EAH.
combatSim(Source, FHealth, FRemainder, EHealth, ERemainder) :- 
	region(Source, _, _, _, Connections),
	aggregateFriendlySim([Source | Connections], FGH, FAH, FGD, FAD, FBD),
	aggregateEnemySim([Source, 0 | Connections], EGH, EAH, EGD, EAD, EBD), !,
	combatSimulation(FGH, FAH, FGD, FAD, FBD,
			 EGH, EAH, EGD, EAD, EBD,
			 FRemainder, ERemainder, 0),
	FHealth is FGH + FAH, EHealth is EGH + EAH.

/*
 * Aggregates the friendlySim/enemySim amounts of all connected regions
 */
aggregateFriendlySim([], 0, 0, 0, 0, 0).
aggregateFriendlySim([H|T], GH, AH, GD, AD, BD) :-
	friendlySim(H, HGH, HAH, HGD, HAD, HBD), aggregateFriendlySim(T, TGH, TAH, TGD, TAD, TBD),
	GH is HGH + TGH, AH is HAH + TAH, GD is HGD + TGD, AD is HAD + TAD, BD is HBD + TBD.
	
aggregateEnemySim([], 0, 0, 0, 0, 0).
aggregateEnemySim([H|T], GH, AH, GD, AD, BD) :-
	enemySim(H, HGH, HAH, HGD, HAD, HBD), aggregateEnemySim(T, TGH, TAH, TGD, TAD, TBD),
	GH is HGH + TGH, AH is HAH + TAH, GD is HGD + TGD, AD is HAD + TAD, BD is HBD + TBD.

/*
 * Returns the health remainders of a fight.
 */
combatSimulation(FGH, FAH, _, _, _, EGH, EAH, _, _, _, FRemainder, ERemainder, 30) :-
	FRemainder is max(0, FGH) + max(0, FAH), ERemainder is max(0, EGH) + max(0, EAH).
combatSimulation(FGH, FAH, _, _, _, EGH, EAH, _, _, _, FRemainder, ERemainder, _) :- EGH =< 0, EAH =< 0,
	FRemainder is max(0, FGH) + max(0, FAH), ERemainder is max(0, EGH) + max(0, EAH).
combatSimulation(FGH, FAH, _, _, _, EGH, EAH, _, _, _, FRemainder, ERemainder, _) :- FGH =< 0, FAH =< 0,
	FRemainder is max(0, FGH) + max(0, FAH), ERemainder is max(0, EGH) + max(0, EAH).
combatSimulation(FGH, FAH, FGD, FAD, FBD, EGH, EAH, EGD, EAD, EBD, FRemainder, ERemainder, Loop) :-
	Loop < 30, (FGH > 0 ; FAH > 0), (EGH > 0 ; EAH > 0),
	(FAH > 0 -> NFGH is FGH - EGD - EBD / 2 ; NFGH is FGH - EGD - EBD),
	(FGH > 0 -> NFAH is FAH - EAD - EBD / 2 ; NFAH is FAH - EAD - EBD),
	(EAH > 0 -> NEGH is EGH - FGD - FBD / 2 ; NEGH is EGH - FGD - FBD),
	(EGH > 0 -> NEAH is EAH - FAD - FBD / 2 ; NEAH is EAH - FAD - FBD),
	NewLoop is Loop + 1, !,
	combatSimulation(NFGH, NFAH, FGD, FAD, FBD, NEGH, NEAH, EGD, EAD, EBD, FRemainder, ERemainder, NewLoop).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% TYPE CHECKS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These units will be ignored for enemy percepts
ignoreUnit('Protoss Scarab').
ignoreUnit('Spell Dark Swarm').
ignoreUnit('Spell Disruption Web').
ignoreUnit('Spell Scanner Sweep').
ignoreUnit('Terran Nuclear Missile').
ignoreUnit('Zerg Cocoon').
ignoreUnit('Zerg Egg').
ignoreUnit('Zerg Larva').
ignoreUnit('Zerg Lurker Egg').

% Non-trivial air targets
isFlyingUnit('Protoss Arbiter').
isFlyingUnit('Protoss Carrier').
isFlyingUnit('Protoss Corsair').
isFlyingUnit('Protoss Interceptor').
isFlyingUnit('Protoss Scout').
isFlyingUnit('Terran Battlecruiser').
isFlyingUnit('Terran Valkyrie').
isFlyingUnit('Terran Wraith').
isFlyingUnit('Zerg Guardian').
isFlyingUnit('Zerg Mutalisk').
isFlyingUnit('Zerg Scourge').
isFlyingUnit('Zerg Devourer').

% All defensive structures
isDefensiveBuilding('Protoss Photon Cannon').
isDefensiveBuilding('Terran Bunker').
isDefensiveBuilding('Terran Missile Turret').
isDefensiveBuilding('Zerg Spore Colony').
isDefensiveBuilding('Zerg Sunken Colony').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% SIGHT RANGES %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All the (sightRange - 1)^2 of units relevant to the battlemind
sightRange('Zerg Zergling', 16).
sightRange('Zerg Hydralisk', 25).
sightRange('Zerg Ultralisk', 36).
%sightRange('Zerg Drone', 36).
%sightRange('Zerg Overlord', 64).
sightRange('Zerg Mutalisk', 36).
%sightRange('Zerg Guardian', 100).
%sightRange('Zerg Queen', 81).
%sightRange('Zerg Defiler', 81).
%sightRange('Zerg Scourge', 16).
%sightRange('Zerg Devourer', 81).
sightRange('Zerg Lurker', 47).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% KNOWLEDGE.PL SCRIPPETS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some of these attack values are modified so that the combatSim is more accurate
combat('Protoss Arbiter',10,10,45,5,0).
combat('Protoss Archon',30,30,20,2,0).
combat('Protoss Carrier',0,0,0,0,0).
combat('Protoss Corsair',0,5,8,5,1).
combat('Protoss Dark Templar',40,0,30,0,0).
combat('Protoss Dragoon',20,20,30,4,0).
combat('Protoss Interceptor',6,6,1,4,0).
combat('Protoss Photon Cannon',20,20,22,7,0).
combat('Protoss Reaver',75,0,0,0,0).
combat('Protoss Scout',8,28,30,4,0).
combat('Protoss Zealot',8,0,22,0,0).
combat('Terran Battlecruiser',25,25,30,6,0).
combat('Terran Bunker',12,12,0,5,0).
combat('Terran Firebat',16,0,22,1,0).
combat('Terran Ghost',10,10,22,7,0).
combat('Terran Goliath',12,20,22,6,0).
combat('Terran Marine',6,6,15,4,0).
combat('Terran Medic',10,10,0,0,0).
combat('Terran Missile Turret',0,20,15,7,0).
combat('Terran Siege Tank',50,0,37,7,0).
combat('Terran Valkyrie',0,12,64,6,1).
combat('Terran Vulture',20,0,30,5,0).
combat('Terran Wraith',8,20,30,5,0).
combat('Zerg Devourer',0,25,100,6,0).
combat('Zerg Guardian',20,0,30,8,0).
combat('Zerg Hydralisk',10,10,15,4,0).
combat('Zerg Lurker',20,0,37,6,0).
combat('Zerg Mutalisk',7,7,30,3,0).
combat('Zerg Scourge',0,20,1,0,0).
combat('Zerg Spore Colony',0,24,15,7,0).
combat('Zerg Sunken Colony',40,0,32,7,0).
combat('Zerg Ultralisk',20,0,15,0,0).
combat('Zerg Zergling',3,0,8,0,0).
