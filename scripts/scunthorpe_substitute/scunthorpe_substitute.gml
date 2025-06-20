function scunthorpe_substitute(_string, _substitutions, _substitutions_length)
{
    for (var i = 0; i < _substitutions_length; ++i)
    {
        var _substitution = _substitutions[i];
        
        var _a = _substitution[0];
        
        if (string_pos(_a, _string) <= 0) continue;
        
        var _repeat = _substitution[2] - _substitution[3];
        
        if (_repeat > 0)
        {
            _string = string_replace_all(_string, _a, _substitution[1] + string_repeat(___SCUNTHORPE_OFFSET_PLACEHOLDER, _repeat));
        }
        else
        {
        	_string = string_replace_all(_string, _a, _substitution[1]);
        }
    }
    
    return _string;
}