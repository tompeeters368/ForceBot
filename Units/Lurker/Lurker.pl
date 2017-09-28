:- dynamic
	self/2,			% (id, type)
 	status/5,		% (health, conditions, x, y, regionid)
	task/2,			% (order, target)
	closestEnemy/4,		% (id, x, y, distance)
	closestBuilding/4,	% (id, x, y, distance)
	target/2,		% (order, id)
	defending/0,		% tracks whether this unit is defending
	retreating/0,		% tracks whether this unit is retreating
	enemyDefense/4,		% (enemyid, type, x, y)
	region/3,		% (regionid, x, y, height, connections)
	regionOrder/3,		% (regionid, targetregion, order)
	map/2,			% (width, height)
	ownMain/3,		% (x, y, regionid)
	ownBase/3,		% (x, y, regionid)
	burrowing/0,		% 
	simDisabled/0		% 
.

% Calculate distance between two points
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points, but do not root it (faster)
distanceSq(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

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

% All defensive structures
isDefensiveBuilding('Protoss Photon Cannon').
isDefensiveBuilding('Terran Bunker').
isDefensiveBuilding('Terran Missile Turret').
isDefensiveBuilding('Zerg Spore Colony').
isDefensiveBuilding('Zerg Sunken Colony').

% (name, static/mobile, range)
%isDetector('Protoss Observer', 'mobile', 9).
%isDetector('Protoss Photon Cannon', 'static', 7).
%isDetector('Terran Missile Turret', 'static', 7).
%isDetector('Terran Science Vessel', 'mobile', 10).
%isDetector('Zerg Overlord', 'mobile', 9).
%isDetector('Zerg Spore Colony', 'static', 7).

% (name, range)
isDetector('Protoss Photon Cannon', 7).
isDetector('Terran Missile Turret', 7).
isDetector('Zerg Spore Colony', 7).

% Non-trivial ground targets (= all ground units + ground-to-ground defensive structures)
isGroundUnit('Protoss Archon').
isGroundUnit('Protoss Dark Archon').
isGroundUnit('Protoss Dark Templar').
isGroundUnit('Protoss Dragoon').
isGroundUnit('Protoss High Templar').
isGroundUnit('Protoss Photon Cannon').
isGroundUnit('Protoss Probe').
isGroundUnit('Protoss Reaver').
isGroundUnit('Protoss Zealot').
isGroundUnit('Terran Bunker').
isGroundUnit('Terran Firebat').
isGroundUnit('Terran Ghost').
isGroundUnit('Terran Goliath').
isGroundUnit('Terran Marine').
isGroundUnit('Terran Medic').
isGroundUnit('Terran SCV').
isGroundUnit('Terran Siege Tank').
isGroundUnit('Terran Vulture').
isGroundUnit('Terran Vulture Spider Mine').
isGroundUnit('Zerg Broodling').
isGroundUnit('Zerg Drone').
isGroundUnit('Zerg Hydralisk').
isGroundUnit('Zerg Infested Terran').
isGroundUnit('Zerg Lurker').
isGroundUnit('Zerg Sunken Colony').
isGroundUnit('Zerg Ultralisk').
isGroundUnit('Zerg Zergling').

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
