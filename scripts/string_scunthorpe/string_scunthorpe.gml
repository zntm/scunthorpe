#macro ___SCUNTHORPE_OFFSET_PLACEHOLDER "\0"
#macro ___SCUNTHORPE_CENSOR_PLACEHOLDER chr(0x8000)

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
        
        var _string_length = string_length(_string);
        
        var _length = _profanity_length;
        
        for (var i = 0; i < _substitutions_length; ++i)
        {
            var _substitution = _substitutions[i];
            
            var _a = _substitution[0];
            
            if (string_pos(_a, _string) <= 0) continue;
            
            var _repeat = (_substitution[2] - _substitution[3]) * string_count(_a, _string);
            
            _length += _repeat;
            
            _string = string_replace_all(_string, _a, "");
        }
        
        return _length;
    }
    
    var _string_length = string_length(_string);
    
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    var _string_substituted = scunthorpe_substitute(_string, _substitutions, _substitutions_length);
    
    var _profanity_extreme        = global.__scunthorpe_extreme;
    var _profanity_extreme_length = array_length(_profanity_extreme);
    
    var _profanity_extreme_group        = global.__scunthorpe_extreme_group;
    var _profanity_extreme_group_length = array_length(_profanity_extreme_group);
    
    var _index_extreme = 0;
    
    // Censor extreme profanity words
    for (var i = _profanity_extreme_group_length - 1; i >= 0; --i)
    {
        var _group_length = _profanity_extreme_group[i];
        
        if (_group_length <= 0) continue;
        
        var _profanity_length = i;
        
        var _censor_base_length = string_repeat(___SCUNTHORPE_CENSOR_PLACEHOLDER, _profanity_length);
        
        for (var j = 0; j < _group_length; ++j)
        {
            var _profanity = _profanity_extreme[_index_extreme + j];
            
            var m = 1;
            
            while (m < _string_length)
            {
                var _string_part = string_delete(_string_substituted, 1, m - 1);
                
                if (!string_starts_with(_string_part, _profanity))
                {
                    ++m;
                    
                    continue;
                }
                
                var _censor_length = __censor_length(m, _string, _profanity, _profanity_length, _substitutions, _substitutions_length);
                
                if (_censor_length > _profanity_length)
                {
                    var _difference = _censor_length - _profanity_length;
                    
                    _censor_length += _difference;
                    
                    _string = string_copy(_string, 1, m - 1) + _censor_base_length + string_repeat(___SCUNTHORPE_CENSOR_PLACEHOLDER, _difference) + string_copy(_string, m + _censor_length - 1, _string_length - (m + _censor_length) + 2);
                }
                else
                {
                    _string = string_copy(_string, 1, m - 1) + _censor_base_length + string_copy(_string, m + _censor_length, _string_length - (m + _censor_length) + 2);
                }
                
                m += _censor_length;
            }
        }
        
        _index_extreme += _group_length;
    }
    
    var _profanity_regular        = global.__scunthorpe_regular;
    var _profanity_regular_length = array_length(_profanity_regular);
    
    var _profanity_regular_group        = global.__scunthorpe_regular_group;
    var _profanity_regular_group_length = array_length(_profanity_regular_group);
    
    // Censor regular profanity words
    var _index_regular = 0;
    
    for (var i = _profanity_regular_group_length - 1; i >= 0; --i)
    {
        var _group_length = _profanity_regular_group[i];
        
        if (_group_length <= 0) continue;
        
        var _profanity_length = i;
        
        var _censor_base_length = string_repeat(___SCUNTHORPE_CENSOR_PLACEHOLDER, _profanity_length);
        
        for (var j = 0; j < _group_length; ++j)
        {
            var _profanity = _profanity_regular[_index_regular + j];
            
            var m = 1;
            
            while (m < _string_length)
            {
                var _string_part = string_delete(_string_substituted, 1, m - 1);
                
                if (!string_starts_with(_string_part, _profanity))
                {
                    ++m;
                    
                    continue;
                }
                
                var _censor_length = __censor_length(m, _string, _profanity, _profanity_length, _substitutions, _substitutions_length);
                
                if ((m > 1) && (string_lettersdigits(string_char_at(_string, m - 1)) != "")) || (string_lettersdigits(string_char_at(_string, m + _censor_length)) != "")
                {
                    ++m;
                    
                    continue;
                }
                
                if (_censor_length > _profanity_length)
                {
                    var _difference = _censor_length - _profanity_length;
                    
                    _censor_length += _difference;
                    
                    _string = string_copy(_string, 1, m - 1) + _censor_base_length + string_repeat(___SCUNTHORPE_CENSOR_PLACEHOLDER, _difference) + string_copy(_string, m + _censor_length - 1, _string_length - (m + _censor_length) + 2);
                }
                else
                {
                    _string = string_copy(_string, 1, m - 1) + _censor_base_length + string_copy(_string, m + _censor_length, _string_length - (m + _censor_length) + 2);
                }
                
                m += _censor_length;
            }
        }
        
        _index_regular += _group_length;
    }
    
    return string_replace_all(_string, ___SCUNTHORPE_CENSOR_PLACEHOLDER, global.__scunthorpe_censor);
}
