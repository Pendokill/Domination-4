// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE_1("","_this")

params ["_map", "_type"]; // _type = 0 normal map control, 1 = GPS, 2 = custom map resources

_map = _map # 0;

//__TRACE_1("","d_show_player_marker")

private _drawdist = d_island_x_max * (ctrlMapScale _map) + 200;
private _mapmid = _map ctrlMapScreenToWorld [0.5, 0.5];

private _fnc_gmi = d_fnc_getmapicon;

if (d_show_player_marker isNotEqualTo 0) then {
	private ["_v", "_inv", "_text", "_crw", "_nmt", "_nt", "_ccrwm1", "_isc", "_vc", "_res"];
	[d_show_player_marker, d_fnc_gethpname, d_mark_loc280, d_fnc_gethpnameai, d_allplayermapd, d_current_ai_units] params ["_s_pl_ma", "_fnc_ghpn", "_d_mark_loc280", "_fnc_ghpnai", "_d_allplayermapd", "_d_current_ai_units"];
	{
		_v = vehicle _x;
		if (_v distance2D _mapmid < _drawdist) then {
			_inv = !isNull objectParent _x;
			//__TRACE_2("","_v","_inv")

			if ([true, _x isEqualTo (crew _v # 0)] select _inv) then {
				_text = if (_type isNotEqualTo 1) then {
					if (!_inv) then {
						_vc = _x getVariable ["d_ut_c", 47];
						if (_vc > 46) then {
							_x setVariable ["d_ut_c", 0];
							call {
								if (_s_pl_ma isEqualTo 1) exitWith {
									_res = if (isPlayer _x) then {
										[_x] call _fnc_ghpn
									} else {
										[_x] call _fnc_ghpnai
									};
								};
								if (_s_pl_ma isEqualTo 2) exitWith {
									_res = "";
								};
								if (_s_pl_ma isEqualTo 3) exitWith {
									_res = format [_d_mark_loc280, 9 - round(9 * damage _x)];
								};
								_res = "";
							};
							_x setVariable ["d_u_text", _res];
							_res
						} else {
							_x setVariable ["d_ut_c", _vc + 1];
							_x getVariable "d_u_text"
						};
					} else {
						if (player distance2D _v < 3000) then {
							_vc = _v getVariable ["d_vma_c", 41];
							if (_vc > 40) then {
								_nmt = _v getVariable "d_ma_text";
								//__TRACE_1("","_nmt")
								if (isNil "_nmt") then {
									_nmt = getText ((configOf _v)>>"displayName");
									_v setVariable ["d_ma_text", _nmt];
								};
								_nt = [_nmt, ": "];
								_crw = crew _v;
								_ccrwm1 = count _crw - 1;
								{
									_nt pushBack (name _x);
									if (_forEachIndex < _ccrwm1) then {
										_nt pushBack ", ";
									};
								} forEach (_crw select {alive _x});
								_v setVariable ["d_vma_c", 0];
								//__TRACE_1("","_nt")
								_res = _nt joinString "";
								_v setVariable ["d_mac_text", _res];
								_res
							} else {
								_v setVariable ["d_vma_c", _vc + 1];
								_v getVariable "d_mac_text";
							};
						} else {
							private _nmt = _v getVariable "d_ma_text";
							if (isNil "_nmt") then {
								_nmt = getText ((configOf _v)>>"displayName");
								_v setVariable ["d_ma_text", _nmt];
							};
							_nmt
						};
					};
				} else {
					""
				};

				_isc = [_v, _x] call _fnc_gmi;

				//__TRACE_1("","_isc")

				_map drawIcon [
					_isc # 0,
					_isc # 2,
					visiblePositionASL _v,
					_isc # 1,
					_isc # 1,
					getDirVisual _v,
					_text,
					1,
					0.05,
					"puristaMedium", // ROBOTO?
					"right"
				];

				if (_inv && {_v getVariable ["d_ism_vec", true]}) then {
					_v setVariable ["d_mvs_not", true];
				};
			};
		};
	} forEach (_d_allplayermapd + (_d_current_ai_units select {alive _x}));
};

//__TRACE_1("","d_marker_vecs")

private ["_isc", "_mt", "_ee"];
private _d_mark_loc261 = d_mark_loc261;
private _d_mark_loc1825 = d_mark_loc1825;
private _marker_vecs = d_marker_vecs;
{
	if (_x distance2D _mapmid < _drawdist) then {
		if !(_x getVariable ["d_mvs_not", false]) then {
			_isc = [_x, objNull, true] call _fnc_gmi;
			//__TRACE_1("","_isc")
			_mt = call {
				if (!alive _x) exitWith {
					_ee = _x getVariable "d_mvdes";
					if (isNil "_ee") then {
						_ee = format [_d_mark_loc1825, _x getVariable "d_ma_text"];
						_x setVariable ["d_mvdes", _ee];
					};
					_ee
				};
				if (_x getVariable ["d_MHQ_Deployed", false]) exitWith {
					_ee = _x getVariable "d_mvdep";
					if (isNil "_ee") then {
						_ee = format [_d_mark_loc261, _x getVariable "d_ma_text"];
						_x setVariable ["d_mvdep", _ee];
					};
					_ee
				};
				_x getVariable "d_ma_text"
			};
			_map drawIcon [
				_isc # 0,
				_isc # 2,
				visiblePositionASL _x,
				_isc # 1,
				_isc # 1,
				getDirVisual _x,
				_mt,
				1,
				0.05,
				"puristaMedium",
				"right"
			];
		} else {
			_x setVariable ["d_mvs_not", nil];
		};
	} else {
		if (_x getVariable ["d_mvs_not", false]) then {
			_x setVariable ["d_mvs_not", nil];
		};
	};
} forEach _marker_vecs select {!isNull _x};
