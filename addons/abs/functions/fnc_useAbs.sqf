#include "script_component.hpp"
/*
 * Author: Salbei
 * Applys ABS, reduzing the wound count below set Value.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Caller <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TARGET, CALLER] call grad_mod_fnc_useAbs
 *
 * Public: Yes
 */
params ["_target", "_caller", "_selection"];

private _loadout = getUnitLoadout _unit;
private _inUniform = _loadout select 3 select 1;
private _inVest = _loadout select 4 select 1;
private _inBackpack = _loadout select 5 select 1;
private _kickOut = false;

for "_i" from 1 to GVAR(amountOfBandagesForABS) do {
   if (count (GVAR(bandagesOnUnit) select 0) > 0) then {
       private _container = GVAR(bandagesOnUnit) select 0;
      _inUniform deleteAt (_inUniform find (_container select 0));
      _container deleteAt 0;
      GVAR(bandagesOnUnit) set [0, _container];
   }else{
      if (count (GVAR(bandagesOnUnit) select 1) > 0) then {
          private _container = GVAR(bandagesOnUnit) select 1;
         _inVest deleteAt (_inVest find (_container select 0));
         _container deleteAt 0;
         GVAR(bandagesOnUnit) set [1, _container];
      }else{
         if (count (GVAR(bandagesOnUnit) select 2) > 0) then {
             private _container = GVAR(bandagesOnUnit) select 2;
            _inBackpack deleteAt (_inBackpack find (_container select 0));
            _container deleteAt 0;
            GVAR(bandagesOnUnit) set [2, _container];

         }else{
            _kickOut = true;
         };
      };
   };

   if (_kickOut) exitWith {diag_log format ["Not enough Bandages: %1 missing.", (GVAR(amountOfBandagesForABS) - _i)]};
};

if (_kickOut) exitWith {};

private _openWounds = _target getVariable ["ace_medical_openWounds", []];
private _wounds = [];
private _notNeededWounds = [];

{
   _x params ["", "", "_bodyPart", "_numOpenWounds", "_bloodLoss"];

   if (_bodyPart == _selection) then {
      _wounds pushBack _x;
   } else {
      _notNeededWounds pushBack _x;
   };
}forEach _openWounds;

if (count _wounds <= 50) exitWith {};

_wounds resize GVAR(amountOfWoundsForABS);
_openWounds = (_wounds + _notNeededWounds) call BIS_fnc_arrayShuffle;
_target setVariable ["ace_medical_openWounds", _openWounds, true];
