function scunthorpe_substitute(_string)
{
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
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

/*
var t = get_timer();

var _text = "TEST MESSAGE IF IT WORKS SAY HI";

#macro SCUNTHORPE_SUBSTITUTION_ALIGNMENT 2

var _length = string_byte_length(_text);
var _buffer = buffer_create(_length, buffer_fixed, 1);

buffer_poke(_buffer, 0, buffer_text, _text);

var _text2 = "MESSAGE";

var _length2 = string_byte_length(_text2);
var _buffer2 = buffer_create(_length2, buffer_fixed, 1);

buffer_poke(_buffer2, 0, buffer_text, _text2);

var _text3 = string_repeat(chr(0x666), 5) + "QQQ";

var _length3 = string_byte_length(_text3);
var _buffer3 = buffer_create(_length3, buffer_fixed, 1);

buffer_poke(_buffer3, 0, buffer_text, _text3);

var _count = 0;
var _count_max = string_length(_text2);
repeat 100000
{
var _pos = 0;

while (buffer_tell(_buffer) < _length)
{
    if (buffer_peek(_buffer2, _count, buffer_u8) == buffer_read(_buffer, buffer_u8))
    {
        if (_count == 0)
        {
            _pos = buffer_tell(_buffer);
        }
        
        ++_count;
        
        if (_count >= _count_max)
        {
            for (var i = 0; i < _count; ++i)
            {
                buffer_poke(_buffer, _pos + i - 1, buffer_u8, buffer_peek(_buffer3, i, buffer_u8));
            }
        }
    }
    else
    {
    	_count = 0;
    }
}
}
show_debug_message(buffer_peek(_buffer, 0, buffer_text));

buffer_delete(_buffer);
buffer_delete(_buffer2);
buffer_delete(_buffer3);

show_debug_message(get_timer() - t);

var t = get_timer();
repeat 100000
var i = string_replace_all(_text, _text2, _text3);

show_debug_message(get_timer() - t);
*/