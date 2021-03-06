:- dynamic
	self/2,			% (id, type)
 	status/5,		% (health, conditions, x, y, regionid)
	task/2,			% (order, target)
	closestEnemy/5,		% (id, x, y, distance, priority)
	target/2,		% (order, id)
	defending/0,		% tracks whether this unit is defending
	retreating/0,		% tracks whether this unit is retreating
	region/3,		% (regionid, x, y, height, connections)
	regionOrder/3,		% (regionid, targetregion, order)
	ownMain/3,		% (x, y, regionid)
	ownBase/3,		% (x, y, regionid)
	map/2			% (width, height)
.

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

% Anything which can threaten air units (excludes Interceptors for now)
canAttackAir('Protoss Arbiter').
canAttackAir('Protoss Archon').
canAttackAir('Protoss Carrier').
canAttackAir('Protoss Corsair').
canAttackAir('Protoss Dark Templar').
canAttackAir('Protoss Dragoon').
canAttackAir('Protoss High Templar').
canAttackAir('Protoss Photon Cannon').
canAttackAir('Protoss Scout').
canAttackAir('Terran Battlecruiser').
canAttackAir('Terran Bunker').
canAttackAir('Terran Ghost').
canAttackAir('Terran Goliath').
canAttackAir('Terran Marine').
canAttackAir('Terran Medic').
canAttackAir('Terran Missile Turret').
canAttackAir('Terran Science Vessel').
canAttackAir('Terran Valkyrie').
canAttackAir('Terran Wraith').
canAttackAir('Zerg Defiler').
canAttackAir('Zerg Devourer').
canAttackAir('Zerg Hydralisk').
canAttackAir('Zerg Mutalisk').
canAttackAir('Zerg Queen').
canAttackAir('Zerg Scourge').
canAttackAir('Zerg Spore Colony').

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
