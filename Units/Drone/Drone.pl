 :- dynamic
	defenseRegion/1,	% (region)
 	status/5,		% (health, conditions, x, y, regionid)
 	target/2,		% (order, target)
 	task/2,			% (order, target)
 	idle/0,			% 
	buildTarget/3,		% (x, y, regionid)
 	mineralRegion/2,	% (id, regionid)
 	mineralBlock/4,		% (id, x, y, regionid)
 	clearingBlock/1,	% (id)
 	chokepoint/6,		% (x1, y1, x2, y2, regionid1, regionid2)
 	enemy/3,		% (id, x, y)
	disableDroneDefense/0	% 
.

% Calculate distance between two points
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X2 - X1)**2 + (Y2 - Y1)**2).
% Calculate distance between two points, but do not root it (faster)
distanceSq(X1, Y1, X2, Y2, D) :- D is (X2 - X1)**2 + (Y2 - Y1)**2.

% Returns true if Type is a worker
isWorker('Protoss Probe').
isWorker('Terran SCV').
isWorker('Zerg Drone').

%% Determines the angle between the two points
%angleBetween(X1, Y1, X2, Y2, Angle) :- X3 is X2 - X1, Y3 is Y2 - Y1, Radians is atan2(Y3, X3), Angle is Radians * 180 / pi.

%% Determines the next kiting point
%kitingPoint(X1, Y1, Angle, X2, Y2) :- Radians is Angle / 180 * pi, X2 is X1 + 10 * cos(Radians), Y2 is Y1 + 10 * sin(Radians).