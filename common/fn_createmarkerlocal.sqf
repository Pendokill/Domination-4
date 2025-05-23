// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE_1("","_this")

// create a local marker, returns created marker
// parameters: marker name, marker pos/object, marker shape, marker color, marker size;(optional) marker text, marker dir, marker type, marker brush
// example: ["my marker",  position player, "hd_dot", "ColorBlue", [0.5,0.5]] call d_fnc_CreateMarkerLocal;
params ["_m_name","_m_pos","_m_shape","_m_col","_m_size"];

if (isNil "_m_pos") exitWith {
	diag_log ["Domination Error: Could not create marker local, _m_pos is nil. Marker name: ", _m_name];
	_m_name
};

if (_m_pos isEqualType [] && {_m_pos isEqualTo []}) exitWith {
	diag_log ["Domination Error: Could not create marker local, position array _m_pos empty. Marker name: ", _m_name];
	_m_name
};

if (_m_pos isEqualType objNull && {isNull _m_pos}) exitWith {
	diag_log ["Domination Error: Could not create marker local, object _m_pos is null. Marker name: ", _m_name, " _m_pos object name: ", _m_pos];
	_m_name
};

private _ma = createMarkerLocal [_m_name, _m_pos];
if (_m_shape isNotEqualTo "") then {_ma setMarkerShapeLocal _m_shape};
if (_m_col isNotEqualTo "") then {_ma setMarkerColorLocal _m_col};
if (_m_size isNotEqualTo []) then {_ma setMarkerSizeLocal _m_size};
private _co = count _this;
if (_co > 5) then {
	if (_this # 5 isNotEqualTo "") then {
		_ma setMarkerTextLocal (_this # 5);
	};
	if (_co > 6) then {
		_ma setMarkerDirLocal (_this # 6);
		if (_co > 7) then {
			if (_this # 7 isNotEqualTo "") then {
				_ma setMarkerTypeLocal (_this # 7);
			};
			if (_co > 8) then {
				if (_this # 8 isNotEqualTo "") then {
					_ma setMarkerBrushLocal (_this # 8);
				};
				if (_co > 9) then {_ma setMarkerAlphaLocal (_this # 9)};
			};
		};
	};
};
_ma