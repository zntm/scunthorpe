#macro SCUNTHORPE_CENSOR_CHAR "*"

function string_scunthorpe(_string)
{
    static __profanity_char = global.profanity_char;
    static __profanity_char_length = array_length(__profanity_char);
    
    static __profanity_char_keys = global.profanity_char_keys;
    
    static __profanity_regular = global.profanity_regular;
    static __profanity_regular_length = array_length(__profanity_regular);
    
    static __profanity_extreme = global.profanity_extreme;
    static __profanity_extreme_length = array_length(__profanity_extreme);
    
    var _string_length = string_length(_string);
    
    var _string_parsed = string_lower(_string);
    var _string_parsed_length = _string_length;
    
    // Filter out ends of the string. This is due to exclamations like 'shit!' and 'WHAT THE FUCK???'
    if (string_lettersdigits(_string_parsed) != _string_parsed)
    {
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
        
        if (_string_parsed_length <= 0)
        {
            return _string;
        }
        
        _string_parsed = string_repeat(" ", _start_length) + _string_parsed + string_repeat(" ", _end_length);
        
        for (var i = 1; i <= _string_length; ++i)
        {
            var _char = string_char_at(_string_parsed, i);
            
            if (!string_pos(_char, __profanity_char_keys)) continue;
            
            for (var j = 0; j < __profanity_char_length; j += 2)
            {
                if (string_pos(_char, __profanity_char[j]) > 0)
                {
                    _string_parsed = string_copy(_string_parsed, 1, i - 1) + __profanity_char[j + 1] + string_copy(_string_parsed, i + 1, _string_length - i);
                    
                    break;
                }
            }
        }
    }
    
    var _string_filtered = _string;
    
    for (var j = 1; j <= _string_length; ++j)
    {
        if (string_letters(string_char_at(_string_parsed, j)) == "") continue;
        
        var _censored = false;
        
        var _length2 = -1;
        
        var _text = -1;
        var _index = -1;
        
        for (var i = 0; i < __profanity_extreme_length; ++i)
        {
            var _profanity = __profanity_extreme[i];
            var _profanity_length = string_length(_profanity);
            
            if (_length2 != _profanity_length)
            {
                _length2 = _profanity_length;
                _index = _profanity_length;
                
                var _string_part = string_copy(_string_parsed, j, _index);
                
                _text = string_letters(_string_part);
                
                if (_text != _string_part)
                {
                    var _text_length = string_length(_text);
                    
                    while (j + _index <= _string_length) && (_text_length < _profanity_length)
                    {
                        var _char = string_letters(string_char_at(_string_parsed, j + _index));
                        
                        if (_char != "")
                        {
                            _text += _char;
                            
                            ++_text_length;
                        }
                        
                        ++_index;
                    }
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
        
        for (var i = 0; i < __profanity_regular_length; ++i)
        {
            var _profanity = __profanity_regular[i];
            var _profanity_length = string_length(_profanity);
            
            if (_length2 != _profanity_length)
            {
                _length2 = _profanity_length;
                _index = _profanity_length;
                
                var _string_part = string_copy(_string_parsed, j, _index);
                
                _text = string_letters(_string_part);
                
                if (_text != _string_part)
                {
                    var _text_length = string_length(_text);
                    
                    while (j + _index <= _string_length) && (_text_length < _profanity_length)
                    {
                        var _char = string_letters(string_char_at(_string_parsed, j + _index));
                        
                        if (_char != "")
                        {
                            _text += _char;
                            
                            ++_text_length;
                        }
                        
                        ++_index;
                    }
                }
            }
            
            if (_text == "") || (string_pos(_profanity, _text) <= 0) continue;
            
            var _string_part = string_copy(_string, j, _index);
            
            if (string_letters(_string_part) != "")
            {
                var _start_index = j - 1;
                var _end_index = _index + j;
                
                if (((_start_index <= 0) || (string_letters(string_char_at(_string, _start_index)) == "")) && ((_end_index > _string_length) || (string_letters(string_char_at(_string, _end_index)) == "")))
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