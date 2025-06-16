function scunthorpe_substitute(_string)
{
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    for (var i = 0; i < _substitutions_length; ++i)
    {
        var _substitution = _substitutions[i];
        
        var _a = _substitution[0];
        var _b = _substitution[1];
        
        // if (string_pos(_a, _string) <= 0) continue;
        
        _string = string_replace_all(_string, _a, _b + string_repeat(SCUNTHORPE_OFFSET_PLACEHOLDER, string_length(_a) - string_length(_b)));
        
    }
    
    return _string;
}