#macro SCUNTHORPE_CENSOR_CHAR "*"

function string_scunthorpe(_string)
{
    static __profanity_char = global.profanity_char;
    static __profanity_char_length = array_length(__profanity_char);
    static __profanity_char_keys = array_length(global.profanity_char_keys);
    
    static __profanity_regular = global.profanity_regular;
    static __profanity_regular_length = array_length(__profanity_regular);
    static __profanity_regular_unique_length = global.profanity_regular_unique_length;
    
    static __profanity_extreme = global.profanity_extreme;
    static __profanity_extreme_length = array_length(__profanity_extreme);
    static __profanity_extreme_unique_length = global.profanity_extreme_unique_length;
    
    static __string = [];
    static __string_parsed = [];
    static __string_parsed_letter = [];
    
    var _string_length = string_length(_string);
    
    var _string_parsed = string_lower(_string);
    var _string_parsed_length = _string_length;
    
    var _start_length = 0;
    var _end_length = 0;
    
    while (_string_parsed_length < 0) && (string_lettersdigits(string_char_at(_string_parsed, 1)) == "")
    {
        _string_parsed = string_delete(_string_parsed, 1, 1);
        
        ++_start_length;
        --_string_parsed_length;
    }
    
    while (_string_parsed_length < 0) && (string_lettersdigits(string_char_at(_string_parsed, _string_length - _end_length)) == "")
    {
        _string_parsed = string_delete(_string_parsed, _string_length - _end_length, 1);
        
        ++_end_length;
        --_string_parsed_length;
    }
    
    _string_parsed = string_repeat(" ", _start_length) + _string_parsed + string_repeat(" ", _end_length);
    
    for (var i = 1; i <= _string_length; ++i)
    {
        var _char = string_char_at(_string_parsed, i);
        
        if (string_pos(_char, __profanity_char_keys) <= 0) break;
        
        for (var j = 0; j < __profanity_char_length; j += 2)
        {
            if (string_pos(_char, __profanity_char[j]) > 0)
            {
                _string_parsed = string_copy(_string_parsed, 1, i - 1) + __profanity_char[j + 1] + string_copy(_string_parsed, i + 1, _string_length - i);
                
                break;
            }
        }
    }
    
    array_resize(__string, _string_length);
    array_resize(__string_parsed, _string_length);
    array_resize(__string_parsed_letter, _string_length);
    
    for (var i = 0; i < _string_length; ++i)
    {
        var _char = string_char_at(_string_parsed, i + 1);
        
        __string[@ i] = string_char_at(_string, i + 1);
        __string_parsed[@ i] = _char;
        __string_parsed_letter[@ i] = string_letters(_char);
    }
    
    var _string_filtered = _string;
    
    for (var j = 1; j <= _string_length; ++j)
    {
        if (__string_parsed_letter[j - 1] == "") continue;
        
        var _censored = false;
        
        var _length2 = -1;
        
        var _text = -1;
        var _index = -1;
        
        var _unique = __profanity_extreme_unique_length[0];
        var _unique_length = 0;
        var _unique_length_index = 0;
        
        for (var i = 0; i < __profanity_extreme_length; ++i)
        {
            if (i > (_unique & ((1 << 32) - 1)))
            {
                _unique = __profanity_extreme_unique_length[++_unique_length_index];
                _unique_length = _unique >> 32;
            }
            
            var _profanity = __profanity_extreme[i];
            var _profanity_length = _unique_length;
            
            if (_length2 != _profanity_length)
            {
                _length2 = _profanity_length;
                
                _index = _profanity_length;
                
                _text = string_letters(string_copy(_string_parsed, j, _index));
                
                var _text_length = string_length(_text);
                
                while (j + _index <= _string_length) && (_text_length < _profanity_length)
                {
                    var _ = __string_parsed_letter[j + _index - 1];
                    
                    if (_ != "")
                    {
                        _text += _;
                        
                        ++_text_length;
                    }
                    
                    ++_index;
                }
            }
             
            if (_text == "") || (string_pos(_profanity, _text) <= 0) continue;
            
            var _string_part = string_copy(_string, j, _index);
            
            if (string_letters(_string_part) != "")
            {
                var _start_index = j - 1;
                var _end_index = _index + j;
                
                _string_filtered = string_copy(_string_filtered, 1, _start_index) + string_repeat(SCUNTHORPE_CENSOR_CHAR, _index) + string_copy(_string_filtered, _end_index, _string_length + _index - _start_index);
                
                j += _index;
                
                _censored = true;
                
                break;
            }
        }
        
        if (_censored) continue;
        
        _length2 = -1;
        
        _text = -1;
        _index = -1;
        
        _unique = __profanity_regular_unique_length[0];
        _unique_length = 0;
        _unique_length_index = 0;
        
        for (var i = 0; i < __profanity_regular_length; ++i)
        {
            if (i > (_unique & ((1 << 32) - 1)))
            {
                _unique = __profanity_regular_unique_length[++_unique_length_index];
                _unique_length = _unique >> 32;
            }
            
            var _profanity = __profanity_regular[i];
            var _profanity_length = _unique_length;
            
            if (_length2 != _profanity_length)
            {
                _length2 = _profanity_length;
                
                _index = _profanity_length;
                
                _text = string_letters(string_copy(_string_parsed, j, _index));
                
                var _text_length = string_length(_text);
                
                while (j + _index <= _string_length) && (_text_length < _profanity_length)
                {
                    var _ = __string_parsed_letter[j + _index - 1];
                    
                    if (_ != "")
                    {
                        _text += _;
                        
                        ++_text_length;
                    }
                    
                    ++_index;
                }
            }
            
            if (_text == "") || (string_pos(_profanity, _text) <= 0) continue;
            
            var _string_part = string_copy(_string, j, _index);
            
            if (string_letters(_string_part) != "")
            {
                var _start_index = j - 1;
                var _end_index = _index + j;
                
                if (((_start_index <= 0) || (string_letters(__string[_start_index - 1]) == "")) && ((_end_index > _string_length) || (string_letters(__string[_end_index - 1]) == "")))
                {
                    _string_filtered = string_copy(_string_filtered, 1, _start_index) + string_repeat(SCUNTHORPE_CENSOR_CHAR, _index) + string_copy(_string_filtered, _end_index, _string_length + _index - _start_index);
                }
            }
            
            j += _index;
            
            break;
        }
    }
    
    return _string_filtered;
}