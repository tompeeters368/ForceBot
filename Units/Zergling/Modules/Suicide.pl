 :- dynamic
	base/3,
	enemyMain/3
.

% Base structures
isBase('Protoss Nexus').
isBase('Terran Command Center').
isBase('Zerg Hatchery').
isBase('Zerg Lair').
isBase('Zerg Hive').

% Base structures
isPriorityTarget('Protoss Pylon').
isPriorityTarget('Terran Supply Depot').
isPriorityTarget('Zerg Creep Colony').
