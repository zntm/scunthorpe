#macro SCUNTHORPE_CENSOR_CHAR "*"

#macro SCUNTHORPE_OFFSET_PLACEHOLDER chr(0x7fff)
#macro SCUNTHORPE_CENSOR_PLACEHOLDER chr(0x8000)

function string_scunthorpe(_string)
{
    static __censor_length = function(_pos, _string, _profanity, _profanity_length, _substitutions, _substitutions_length)
    {
        _string = string_delete(_string, 1, _pos - 1);
        
        var _length = 0;
        
        for (var i = 0; i < _profanity_length; ++i)
        {
            if (string_char_at(_string, _length + 1) == string_char_at(_profanity, i + 1))
            {
                ++_length;
                
                continue;
            }
            
            for (var j = 0; j < _substitutions_length; ++j)
            {
                var _substitution = _substitutions[j][0];
                var _substitution_length = string_length(_substitution);
                
                if (string_copy(_string, _length + 1, _substitution_length) == _substitution)
                {
                    _length += _substitution_length;
                    
                    break;
                }
            }
        }
        
        return _length;
    }
    
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    var _profanity_regular        = global.__scunthorpe_regular;
    var _profanity_regular_length = array_length(_profanity_regular);
    
    var _profanity_extreme        = global.__scunthorpe_extreme;
    var _profanity_extreme_length = array_length(_profanity_extreme);
    
    var _string_length = string_length(_string);
    
    // Censor extreme profanity words
    for (var i = 0; i < _profanity_extreme_length; ++i)
    {
        var _profanity = _profanity_extreme[i];
        var _profanity_length = string_length(_profanity);
        
        var j = 1;
        
        while (j < _string_length)
        {
            show_debug_message(scunthorpe_substitute(string_copy(_string, j, _string_length)));
            
            if (!string_starts_with(string_replace_all(scunthorpe_substitute(string_copy(_string, j, _string_length)), SCUNTHORPE_OFFSET_PLACEHOLDER, ""), _profanity))
            {
                ++j;
                
                continue;
            }
            
            var _censor_length = __censor_length(j, _string, _profanity, _profanity_length, _substitutions, _substitutions_length);
            var _censor        = string_repeat(SCUNTHORPE_CENSOR_PLACEHOLDER, _censor_length);
            
            _string = string_copy(_string, 1, j - 1) + _censor + string_copy(_string, j + _censor_length, _string_length - (j + _censor_length - 1));
            
            j += _censor_length;
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
            var _censor_length = __censor_length(_profanity, _pos, _string_parsed, _string_length, _substitutions, _substitutions_length);
            var _censor        = string_repeat(SCUNTHORPE_CENSOR_CHAR, _profanity_length + _censor_length);
            
            _string_parsed = string_copy(_string_parsed, 1, _pos - 1) + _censor + string_copy(_string_parsed, _pos + _profanity_length + _censor_length, _string_length - (_pos + _profanity_length + _censor_length - 1));
            
            if (string_lettersdigits(string_char_at(_string_parsed, _pos - 1)) == "") && (string_lettersdigits(string_char_at(_string_parsed, _pos + _profanity_length)) == "")
            {
                _string = string_copy(_string, 1, _pos - 1) + _censor + string_copy(_string, _pos + _profanity_length + _censor_length, _string_length - (_pos + _profanity_length + _censor_length - 1));
            }
            
            _pos = string_pos(_profanity, _string_parsed);
        }
    }
    */
    return string_replace_all(_string, SCUNTHORPE_CENSOR_PLACEHOLDER, SCUNTHORPE_CENSOR_CHAR);
}