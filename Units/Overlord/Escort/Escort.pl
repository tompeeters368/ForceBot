 :- dynamic
 	map/2,
	regionOrder/3,
	ownMain/3
.

getDetectPoint(X1, Y1, X2, Y2) :- (antennae -> Offset is 9 ; Offset is 7), map(Width, Height), ownMain(X3, Y3, _), radiansBetweenPoints(X1, Y1, X3, Y3, Radians),
	X2 is min(Width, max(0, X1 + Offset * cos(Radians))), Y2 is min(Height, max(0, Y1 + Offset * sin(Radians))).

radiansBetweenPoints(X1, Y1, X2, Y2, Radians) :- Radians is atan2(Y2 - Y1, X2 - X1).
