#macro SCUNTHORPE_CENSOR_CHAR "*"

#macro SCUNTHORPE_IS_REALWORD_ONLY true

function string_scunthorpe(_string)
{
    static __censor_extend = function(_profanity, _pos, _string, _string_length, _substitutions, _substitutions_length)
    {
        var _extend = 0;
        
        var _ = string_lower(string_copy(_string, _pos, _string_length));
        
        for (var j = 0; j < _substitutions_length; ++j)
        {
            var _substitution = _substitutions[j];
            
            var _a = _substitution[0];
            
            var _count = string_count(_a, _string);
            
            if (_count > 0)
            {
                show_debug_message($"g: {_count} {_a} {_substitution} {_string}")
                _extend += (string_length(_a) - 1) * _count;
            }
        }
        
        return _extend;
    }
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    var _profanity_regular        = global.__scunthorpe_regular;
    var _profanity_regular_length = array_length(_profanity_regular);
    
    var _profanity_extreme        = global.__scunthorpe_extreme;
    var _profanity_extreme_length = array_length(_profanity_extreme);
    
    var _string_length = string_length(_string);
    
    var _string_parsed = scunthorpe_substitute(string_lower(_string));
    
    // Censor extreme profanity words
    for (var i = 0; i < _profanity_extreme_length; ++i)
    {
        var _profanity = _profanity_extreme[i];
        var _profanity_length = string_length(_profanity);
        
        var _pos = string_pos(_profanity, _string_parsed);
        
        while (_pos > 0)
        {
            _pos = string_pos(_profanity, _string_parsed);
            
            var _censor_extend = __censor_extend(_profanity, _pos, _string, _string_length, _substitutions, _substitutions_length);
            var _censor        = string_repeat(SCUNTHORPE_CENSOR_CHAR, _profanity_length + _censor_extend);
            
            _string        = string_copy(_string,        1, _pos - 1) + _censor + string_copy(_string,        _pos + _profanity_length, _string_length - (_pos + _profanity_length - 1));
            _string_parsed = string_copy(_string_parsed, 1, _pos - 1) + _censor + string_copy(_string_parsed, _pos + _profanity_length, _string_length - (_pos + _profanity_length - 1));
            
            show_debug_message($"{_censor_extend} {_string_parsed} {_censor} {_profanity}")
        }
    }
    /*
    // Censor regular profanity words
    for (var i = 0; i < _profanity_regular_length; ++i)
    {
        var _profanity = _profanity_regular[i];
        var _profanity_length = string_length(_profanity);
        
        var _pos = string_pos(_profanity, _string_parsed);
        
        while (_pos > 0)
        {
            var _censor_extend = __censor_extend(_profanity, _pos, _string_parsed, _string_length, _substitutions, _substitutions_length);
            var _censor        = string_repeat(SCUNTHORPE_CENSOR_CHAR, _profanity_length + _censor_extend);
            
            _string_parsed = string_copy(_string_parsed, 1, _pos - 1) + _censor + string_copy(_string_parsed, _pos + _profanity_length + _censor_extend, _string_length - (_pos + _profanity_length + _censor_extend - 1));
            
            if (string_lettersdigits(string_char_at(_string_parsed, _pos - 1)) == "") && (string_lettersdigits(string_char_at(_string_parsed, _pos + _profanity_length)) == "")
            {
                _string = string_copy(_string, 1, _pos - 1) + _censor + string_copy(_string, _pos + _profanity_length + _censor_extend, _string_length - (_pos + _profanity_length + _censor_extend - 1));
            }
            
            _pos = string_pos(_profanity, _string_parsed);
        }
    }
    */
    return _string;
}