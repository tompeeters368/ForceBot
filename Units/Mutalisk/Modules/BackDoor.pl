:-dynamic
		stage/1,
		waypoints/1,
		waypointsIndex/1,
		debugdraw/1,
		
		status/8,
		target/3,
 		map/2,
 		task/2.
 
% nextPoint/1
% Get the next point to go to.
nextPoint(P) :- waypoints(L), waypointsIndex(I), nth0(I, L, P).
 
% me/2
% Where I Am
me(X, Y) :- status(_, _, _, _, _, X, Y, _).

% getRouteTo/3
% Call the getRouteTo/4 predicate in both cw and ccw rotation. 
% It calculates which direction is shorter.
% Then returns a list of points that must be followed to execute
% that route.
getRouteTo(point(X, Y), List, Distance) :-
	getRouteTo(point(X, Y), List, Distance, cw),
	getRouteTo(point(X, Y), _, Distance2, ccw),
	Distance < Distance2, !.
getRouteTo(point(X, Y), List, Distance) :-
	getRouteTo(point(X, Y), _, Distance2, cw),
	getRouteTo(point(X, Y), List, Distance, ccw),
	Distance =< Distance2.

% mapCorner/2
% The 4 corners of the map, named and coordinates.
mapCorner(tl, point(0, 0)).			% Top left
mapCorner(tr, point(W, 0)) :- map(W, _).	% Top right
mapCorner(bl, point(0, H)) :- map(_, H).	% Bottom left
mapCorner(br, point(W, H)) :- map(W, H).	% Bottom right

% Get current location in side information.
% IN	point(X, Y)
% OUT	name of the zone (either tl,tr,bl,br,top,right,bottom,left)
sideZone(point(X, Y), Zone) :- mapCorner(Zone, point(Xp, Yp)), sqrt(abs(X-Xp)**2 + abs(Y-Yp)**2) < 3, !.
sideZone(point(X, Y), left) :- wallPoint(point(X, Y), point(0, _)), !.
sideZone(point(X, Y), top) :- wallPoint(point(X, Y), point(_, 0)), !.
sideZone(point(X, Y), right) :- wallPoint(point(X, Y), point(W, _)), map(W, _), !.
sideZone(point(X, Y), bottom) :- wallPoint(point(X, Y), point(_, H)), map(_, H), !.

% How the map segments are connected.
edge(tl, top).	
edge(top, tr).
edge(tr, right).
edge(right, br).
edge(br, bottom).
edge(bottom, bl).
edge(bl, left).
edge(left, tl).

% What the next segment in either clockwise or counterclockwise rotation
next(From, To, cw) :- edge(From, To).
next(From, To, ccw) :- edge(To, From).

% For a given coordinate system, tell the closest wall location + distance to it
xCoordinate(Start, End, Distance) :- map(W, _), Start < W - Start, End is 0, Distance is Start, !.
xCoordinate(Start, End, Distance) :- map(W, _), Start >= W - Start, End is W, Distance is W - Start.
yCoordinate(Start, End, Distance) :- map(_, H), Start < H - Start, End is 0, Distance is Start, !.
yCoordinate(Start, End, Distance) :- map(_, H), Start >= H - Start, End is H, Distance is H - Start.

% Find out which wall segment is closest to current position + its location
wallPoint(point(X, Y), point(XLoc, Y)) :-
	xCoordinate(X, XLoc, DX), yCoordinate(Y, _, DY), DX =< DY, !.
wallPoint(point(X, Y), point(X, YLoc)) :-
	xCoordinate(X, _, DX), yCoordinate(Y, YLoc, DY), DX > DY.

% getRouteTo/4
% private predicate used to find the distance from my current position to point(X, Y)
getRouteTo(point(X, Y), List, Distance, Rotation) :-
	me(Xme, Yme),
	wallPoint(point(X, Y), point(Xend, Yend)),
	wallPoint(point(Xme, Yme), point(Xw, Yw)),
	sideZone(point(Xw, Yw), ZoneS),
	sideZone(point(Xend, Yend), ZoneE),
	getRoute(ZoneS, ZoneE, Rotation, Segment),
	append([point(Xw, Yw)], Segment, List1),
	append(List1, [point(Xend, Yend)], List),
	calculateDistance(List, 0, Distance), !.

% getRoute/4
% find the list of points that make up the route between ZoneS and ZoneE
getRoute(Zone, Zone, Rotation, []).
getRoute(ZoneS, ZoneE, Rotation, List) :-
	next(ZoneS, ZoneT, Rotation),
	mapCorner(ZoneT, point(X, Y)),
	getRoute(ZoneT, ZoneE, Rotation, List2),
	append([point(X, Y)], List2, List), !.
getRoute(ZoneS, ZoneE, Rotation, List) :-
	next(ZoneS, ZoneT, Rotation),
	getRoute(ZoneT, ZoneE, Rotation, List).

% distance/5, distance/2, distance/3
distance(X1,Y1,X2,Y2,Distance) :- Distance is sqrt(abs(X1-X2)**2 + abs(Y1-Y2)**2).
distance(point(X, Y), Distance) :- me(X1, Y1), Distance is sqrt(abs(X-X1)**2 + abs(Y-Y1)**2).
distance(point(X, Y), point(X1, Y1), Distance) :- Distance is sqrt(abs(X-X1)**2 + abs(Y-Y1)**2).

% calculateDistance/3
% predicate that computes the total distance from a list of points. 
calculateDistance([P1, P2], Acc, Distance) :- distance(P1, P2, D), Distance is Acc + D, !.
calculateDistance([P1, P2|T], Acc, Distance) :- distance(P1, P2, D), NA is Acc + D, calculateDistance([P2|T], NA, Distance).
calculateDistance([], Acc, Acc).
calculateDistance([_], Acc, Acc).