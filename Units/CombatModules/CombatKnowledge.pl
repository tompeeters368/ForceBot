/* 
* This file is unused but contains various different units classifications which can be copied to other knowledge files.
*/

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

% (name, static/mobile, range)
isDetector('Protoss Observer', 'mobile', 9).
isDetector('Protoss Photon Cannon', 'static', 7).
isDetector('Terran Missile Turret', 'static', 7).
isDetector('Terran Science Vessel', 'mobile', 10).
isDetector('Zerg Overlord', 'mobile', 9).
isDetector('Zerg Spore Colony', 'static', 7).

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

% All our fighter units
isFighter('Zerg Devourer').
isFighter('Zerg Guardian').
isFighter('Zerg Hydralisk').
isFighter('Zerg Lurker').
isFighter('Zerg Mutalisk').
isFighter('Zerg Scourge').
isFighter('Zerg Ultralisk').
isFighter('Zerg Zergling').
isFighter('Zerg Sunken Colony').
isFighter('Zerg Spore Colony').

% All structures
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

% All defensive structures
isDefensiveBuilding('Protoss Photon Cannon').
isDefensiveBuilding('Terran Bunker').
isDefensiveBuilding('Terran Missile Turret').
isDefensiveBuilding('Zerg Spore Colony').
isDefensiveBuilding('Zerg Sunken Colony').
