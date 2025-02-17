global.profanity_char = [
    "\@4", "a",
    "\$5", "s",
    "3", "e",
    "\!1\|", "i",
    "0", "o",
    "7\+", "t",
    "8", "b",
    "6", "g",
    "9", "g",
    "0", "o"
];



var _buffer = buffer_load("profanity_extreme");

global.profanity_extreme = string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n");

buffer_delete(_buffer);

var _buffer = buffer_load("profanity");

global.profanity = array_concat(global.profanity_extreme, string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n"));

buffer_delete(_buffer);

show_debug_message(global.profanity_extreme)
show_debug_message(global.profanity)

function profanity_filter(_string)
{
    static __profanity_char = global.profanity_char;
    static __profanity_char_length = array_length(__profanity_char);
    
    static __profanity = global.profanity;
    static __profanity_length = array_length(__profanity);
    
    static __profanity_extreme = global.profanity_extreme;
    
    var _string_length = string_length(_string);
    
    var _string_filtered = "";
    
    var _string3 = _string;
    
    var _start_length = 0;
    var _end_length = 0;
    
    while (string_lettersdigits(string_char_at(_string3, 1)) == "")
    {
        _string3 = string_copy(_string3, 2, _string_length + ++_start_length);
    }
    
    while (string_lettersdigits(string_char_at(_string3, _string_length - _end_length)) == "")
    {
        _string3 = string_copy(_string3, 1, _string_length - ++_end_length);
    }
    
    _string3 = string_repeat(" ", _start_length) + _string3 + string_repeat(" ", _end_length)
    
    for (var i = 1; i <= _string_length; ++i)
    {
        var _char = string_char_at(_string3, i);
        
        var _broke = false;
        
        for (var j = 0; j < __profanity_char_length; j += 2)
        {
            if (string_pos(_char, __profanity_char[j]) <= 0) continue;
            
            _string_filtered += __profanity_char[j + 1];
            
            _broke = true;
            
            break;
        }
        
        if (!_broke)
        {
            var _ = string_lower(_char);
            
            if (string_letters(_) != "")
            {
                _string_filtered += _;
            }
            else
            {
                _string_filtered += " ";
            }
        }
    }
    
    var _string2 = _string;
    
    for (var i = 0; i < __profanity_length; ++i)
    {
        var _profanity = __profanity[i];
        var _profanity_length = string_length(_profanity);
        
        for (var j = 1; j <= _string_length; ++j)
        {
            if (string_letters(string_char_at(_string_filtered, j)) == "") continue;
            
            var _index = _profanity_length;
            
            while (_index <= _string_length) && (string_length(string_letters(string_copy(_string_filtered, j, _index))) < _profanity_length)
            {
                ++_index;
            }
            
            var _text = string_letters(string_copy(_string_filtered, j, _index));
            
            if (string_pos(_profanity, _text) > 0)
            {
                var _2 = string_copy(_string, j, _index);
                
                if (string_digits(_2) == _2)
                {
                    j += _index;
                    
                    continue;
                }
                
                var _x1 = j - 1;
                var _x2 = _index + 1;
                
                var _ = string_copy(_string_filtered, _x1, _x2 - j);
                
                // show_debug_message(_);
                
                if (array_contains(__profanity_extreme, _profanity)) ||
                // (_ == _profanity) ||
                (((_x1 - 1 <= 0) || (string_letters(string_char_at(_string_filtered, _x1)) == "")) &&
                ((j + _index - 1 >= _string_length) || (string_letters(string_char_at(_string_filtered, j + _index)) == "")))
                {
                    _string2 = string_copy(_string2, 1, j - 1) + string_repeat("*", _index) + string_copy(_string2, j + _index, _string_length - j + _index - 1);
                }
                
                j += _index;
            }
        }
    }
    
    return _string2;
}