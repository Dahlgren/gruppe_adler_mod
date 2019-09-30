#include "script_component.hpp"

params ["_saveName", "_mapName", ["_markersData", []]];

{
    _x params [
        "_alpha",
        "_brush",
        "_color",
        "_dir",
        "_pos",
        "_shape",
        "_size",
        "_text",
        "_type",
        "_channel"
    ];

    private _markerID = format ["_USER_DEFINED #-1%1%2/%3/%4", _saveName, _mapName, _forEachIndex, _channel];

    private _marker = createMarkerLocal [_markerID, _pos];
    _marker setMarkerAlphaLocal _alpha;
    _marker setMarkerBrushLocal _brush;
    _marker setMarkerColorLocal _color;
    _marker setMarkerDirLocal _dir;
    _marker setMarkerPosLocal _pos;
    _marker setMarkerShapeLocal _shape;
    _marker setMarkerSizeLocal _size;
    _marker setMarkerTextLocal _text;
    _marker setMarkerTypeLocal _type;

} forEach _markersData;
