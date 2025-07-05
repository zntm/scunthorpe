#macro ___SCUNTHORPE_OFFSET_PLACEHOLDER chr(0)

/**
 * Profanity filtering function using the "Scunthorpe problem" approach.
 * @pure
 * @self
 * @param {string} _string The string that will be filtered.
 * @return {string} The filtered string with profanity censored.
 */
function string_scunthorpe(_string)
{
    static __censor_length = function(_pos, _string, _profanity, _profanity_length, _substitutions, _substitutions_length)
    {
        _string = string_delete(_string, 1, _pos - 1);
        
        var _length = _profanity_length;
        
        for (var i = 0; i < _substitutions_length; ++i)
        {
            var _substitution = _substitutions[i];
            
            var _a = _substitution[0];
            
            var _count = string_count(_a, _string);
            
            if (_count <= 0) continue;
            
            _length += (_substitution[2] - _substitution[3]) * _count;
            
            _string = string_replace_all(_string, _a, "");
        }
        
        return _length;
    }
    
    var _string_length = string_length(_string);
    
    var _censor_char = global.__scunthorpe_censor_char;
    
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    var _profanity_extreme        = global.__scunthorpe_extreme;
    var _profanity_extreme_length = array_length(_profanity_extreme);
    
    var _profanity_extreme_group        = global.__scunthorpe_extreme_group;
    var _profanity_extreme_group_length = array_length(_profanity_extreme_group);
    
    var _profanity_regular        = global.__scunthorpe_regular;
    var _profanity_regular_length = array_length(_profanity_regular);
    
    var _profanity_regular_group        = global.__scunthorpe_regular_group;
    var _profanity_regular_group_length = array_length(_profanity_regular_group);
    
    // Censor extreme profanity words
    for (var i = 0; i < _string_length; ++i)
    {
        var _index_extreme = 0;
        
        var _ = string_lower(scunthorpe_substitute(string_delete(_string, 1, i), _substitutions, _substitutions_length));
        
        var _pos = i + 1;
        
        for (var j = _profanity_extreme_group_length - 1; j >= 0; --j)
        {
            var _group_length = _profanity_extreme_group[j];
            
            if (_group_length <= 0) continue;
            
            var _profanity_length = j;
            
            for (var l = 0; l < _group_length; ++l)
            {
                var _profanity = _profanity_extreme[_index_extreme + l];
                
                if (string_starts_with(_, _profanity))
                {
                    var _count = __censor_length(_pos, _string, _profanity, _profanity_length, _substitutions, _substitutions_length);
                    
                    _string = string_insert(string_repeat(_censor_char, _count), string_delete(_string, _pos, _count), _pos);
                }
            }
            
            _index_extreme += _group_length;
        }
    }
    
    for (var i = 0; i < _string_length; ++i)
    {
        var _index_regular = 0;
        
        var _ = string_lower(scunthorpe_substitute(string_delete(_string, 1, i), _substitutions, _substitutions_length));
        
        var _pos = i + 1;
        
        for (var j = _profanity_regular_group_length - 1; j >= 0; --j)
        {
            var _group_length = _profanity_regular_group[j];
            
            if (_group_length <= 0) continue;
            
            var _profanity_length = j;
            
            for (var l = 0; l < _group_length; ++l)
            {
                var _profanity = _profanity_regular[_index_regular + l];
                
                if (string_starts_with(_, _profanity))
                {
                    var _count = __censor_length(_pos, _string, _profanity, _profanity_length, _substitutions, _substitutions_length);
                    
                    if (string_lettersdigits(string_char_at(_string, _pos - 1)) == "") && (string_lettersdigits(string_char_at(_string, _pos + _count)) == "")
                    {
                        _string = string_insert(string_repeat(_censor_char, _count), string_delete(_string, _pos, _count), _pos);
                    }
                }
            }
            
            _index_regular += _group_length;
        }
    }
    
    return _string;
}
