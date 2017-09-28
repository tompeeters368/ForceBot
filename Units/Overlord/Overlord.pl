 :- dynamic
 	task/2,
 	target/2,
 	status/5,
 	order/3,
 	map/2,
	region/3,
	watchPoint/4,
	antennae/0,
	enemyMain/3
.

% Calculate distance between two points
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points, but do not root it (faster)
distanceSq(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

getWatchPoint(X1, Y1, X2, Y2) :- (antennae -> Range is 11 ; Range is 9), X3 is X1 + 2, Y3 is Y1 + 1,
	map(Width, Height), enemyMain(X4, Y4, _), radiansBetweenPoints(X4, Y4, X3, Y3, Radians),
	X2 is min(Width, max(0, X3 + Range * cos(Radians))), Y2 is min(Height, max(0, Y3 + Range * sin(Radians))).

radiansBetweenPoints(X1, Y1, X2, Y2, Radians) :- Radians is atan2(Y2 - Y1, X2 - X1).

% All buildings
isBuilding('Protoss Arbiter Tribunal').
isBuilding('Protoss Assimilator').
isBuilding('Protoss Citadel of Adun').
isBuilding('Protoss Cybernetics Core').
isBuilding('Protoss Fleet Beacon').
isBuilding('Protoss Forge').
isBuilding('Protoss Gateway').
isBuilding('Protoss Nexus').
isBuilding('Protoss Observatory').
isBuilding('Protoss Photon Cannon').
isBuilding('Protoss Pylon').
isBuilding('Protoss Robotics Facility').
isBuilding('Protoss Robotics Support Bay').
isBuilding('Protoss Shield Battery').
isBuilding('Protoss Stargate').
isBuilding('Protoss Templar Archives').
isBuilding('Terran Academy').
isBuilding('Terran Armory').
isBuilding('Terran Bunker').
isBuilding('Terran Barracks').
isBuilding('Terran Command Center').
isBuilding('Terran Engineering Bay').
isBuilding('Terran Factory').
isBuilding('Terran Missile Turret').
isBuilding('Terran Refinery').
isBuilding('Terran Science Facility').
isBuilding('Terran Starport').
isBuilding('Terran Supply Depot').
isBuilding('Zerg Creep Colony').
isBuilding('Zerg Defiler Mound').
isBuilding('Zerg Evolution Chamber').
isBuilding('Zerg Extractor').
isBuilding('Zerg Greater Spire').
isBuilding('Zerg Hatchery').
isBuilding('Zerg Hive').
isBuilding('Zerg Hydralisk Den').
isBuilding('Zerg Infested Command Center').
isBuilding('Zerg Lair').
isBuilding('Zerg Nydus Canal').
isBuilding('Zerg Queens Nest').
isBuilding('Zerg Spawning Pool').
isBuilding('Zerg Spire').
isBuilding('Zerg Spore Colony').
isBuilding('Zerg Sunken Colony').
isBuilding('Zerg Ultralisk Cavern').
