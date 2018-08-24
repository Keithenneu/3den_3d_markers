// TODO: cache config lookups

bso_draw_3den_markers =
{
    {
        private _type = (_x get3DENAttribute "markerType") select 0;
        if (_type isEqualTo -1) then {
            private _class = (_x get3DENAttribute "itemClass") select 0;
            private _icon = getText (configFile >> "CfgMarkers" >> _class >> "icon");
            private _text = (_x get3DENAttribute "text") select 0;
            private _size = (_x get3DENAttribute "size2") select 0;
            private _position = (_x get3DENAttribute "position") select 0;
            _position set [2, 0];
            private _colorName = (_x get3DENAttribute "baseColor") select 0;
            private _color = getArray (configFile >> "CfgMarkerColors" >> _colorName >> "color");
            if (_colorName == "Default") then {
                _color = getArray (configFile >> "CfgMarkers" >> _class >> "color");
            };
            _color = _color apply {
                if (_x isEqualType "") then {call compile _x} else {_x};
            };
            private _alpha = (_x get3DENAttribute "alpha") select 0;
            _color set [3, _alpha];
            drawIcon3D [_icon, _color, _position, _size select 0, _size select 1, 0, _text];
        };
    } foreach (all3DENEntities select 5);
};

bso_draw_3den_markers_id = addMissionEventHandler ["Draw3d", {[] call bso_draw_3den_markers}];