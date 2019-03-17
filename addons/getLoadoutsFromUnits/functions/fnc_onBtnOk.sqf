#include "script_component.hpp"
#include "..\IDCs.hpp"

// called upon display load
// PARAMS:
// 	0: Display <DISPLAY>

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
disableSerialization;

private _display = ctrlParent _control;
private _structuredText = [];

diag_log "ONBTNOK!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";

GVAR(variables) params ["_units", "_types"];

private _tab = "    ";
private _doubleTab = _tab + _tab;

{
    private _ctrlCombo = _display displayCtrl _x;

    private _unit = (_ctrlCombo lbData (lbCurSel _ctrlCombo));
    diag_log format ["_unit = %1", _unit];
    if !(_unit isEqualTo "") then {
        [_unit, _forEachIndex] call FUNC(addMedicItems);
    };
}forEach [IDC_CFR, IDC_SQL, IDC_PTL];

_structuredText pushBack format ["class %1 {", (_display displayCtrl IDC_NAME)];
_structuredText pushBack (_tab + "class AllUnits {");
_structuredText append ([
    "uniform",
    "backpack",
    "vest",
    "primaryWeapon",
    "primaryWeaponMagazine",
    "primaryWeaponMuzzle",
    "primaryWeaponOptics",
    "primaryWeaponPointer",
    "primaryWeaponUnderbarrel",
    "primaryWeaponUnderbarrelMagazine",
    "secondaryWeapon",
    "secondaryWeaponMagazine",
    "secondaryWeaponMuzzle",
    "secondaryWeaponOptics",
    "secondaryWeaponPointer",
    "secondaryWeaponUnderbarrel",
    "secondaryWeaponUnderbarrelMagazine",
    "handgunWeapon",
    "handgunWeaponMagazine",
    "handgunWeaponMuzzle",
    "handgunWeaponOptics",
    "handgunWeaponPointer",
    "handgunWeaponUnderbarrel",
    "handgunWeaponUnderbarrelMagazine",
    "headgear",
    "goggles",
    "nvgoggles",
    "binoculars",
    "map",
    "gps",
    "compass",
    "watch",
    "radio"
] apply {_doubleTab + _x + " = """";"});
_structuredText pushBack (_tab + "};");
_structuredText pushBack (_tab + "class Type {");

{
    _structuredText append ([_x, (_types select _forEachIndex), _tab] call FUNC(getLoadoutAndFormat));
}forEach _units;

_structuredText pushBack (_tab + "};");
_structuredText pushBack "};";

GVAR(variables) = nil;

copyToClipboard (_structuredText joinString (toString [13,10]));
