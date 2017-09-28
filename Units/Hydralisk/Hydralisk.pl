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
	map/2,			% (width, height)
	ownMain/3,		% (x, y, regionid)
	ownBase/3,		% (x, y, regionid)
	morphing/1		% (type)
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

% Anything which can threaten ground units
canAttackGround('Protoss Probe').
canAttackGround('Protoss Zealot').
canAttackGround('Protoss Dragoon').
canAttackGround('Protoss High Templar').
canAttackGround('Protoss Dark Templar').
canAttackGround('Protoss Reaver').
canAttackGround('Protoss Archon').
canAttackGround('Protoss Dark Archon').
canAttackGround('Protoss Scout').
canAttackGround('Protoss Carrier').
canAttackGround('Protoss Interceptor').
canAttackGround('Protoss Arbiter').
canAttackGround('Protoss Arbiter').
canAttackGround('Protoss Photon Cannon').
canAttackGround('Terran SCV').
canAttackGround('Terran Marine').
canAttackGround('Terran Firebat').
canAttackGround('Terran Medic').
canAttackGround('Terran Ghost').
canAttackGround('Terran Vulture').
canAttackGround('Terran Vulture Spider Mine').
canAttackGround('Terran Siege Tank').
canAttackGround('Terran Goliath').
canAttackGround('Terran Wraith').
canAttackGround('Terran Science Vessel').
canAttackGround('Terran Battlecruiser').
canAttackGround('Terran Bunker').
canAttackGround('Zerg Drone').
canAttackGround('Zerg Zergling').
canAttackGround('Zerg Hydralisk').
canAttackGround('Zerg Lurker').
canAttackGround('Zerg Ultralisk').
canAttackGround('Zerg Defiler').
canAttackGround('Zerg Infested Terran').
canAttackGround('Zerg Broodling').
canAttackGround('Zerg Defiler').
canAttackGround('Zerg Overlord').
canAttackGround('Zerg Mutalisk').
canAttackGround('Zerg Queen').
canAttackGround('Zerg Guardian').
canAttackGround('Zerg Devourer').
canAttackGround('Zerg Sunken Colony').

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
