#include "script_component.hpp"
#include "..\ui\defines.hpp"

params ["_ctrlButtonSave"];

if (count GVAR(selectedMarkers) == 0) exitWith {};

private _display = ctrlParent _ctrlButtonSave;
private _ctrlEdit = _display displayCtrl IDC_EDITNAME;

private _saveAs = ctrlText _ctrlEdit;

private _listbox = _display displayCtrl IDC_SIDELIST;
private _side = (_listbox lbData (lbCurSel _listbox));

if !(_side isEqualTo "") then {_side = "ALL";};

[_saveAs, worldName, GVAR(selectedMarkers), _side] call FUNC(saveMarkers);
[_display] call FUNC(updateSavesList);
[_display, -1] call FUNC(setListSelected);
