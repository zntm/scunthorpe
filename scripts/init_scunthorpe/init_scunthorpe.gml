global.profanity_char = [
    "3\&",   "e",
    "7\+",   "t",
    "\@4",   "a",
    "0",     "o",
    "\!1\|", "i",
    "\$5",   "s",
    "\#",    "h",
    "\(",    "c",
    "69",    "g",
    "8",     "b",
    "\%",    "x",
    "2",     "z"
];

global.profanity_char_keys = "";

var _profanity_char_length = array_length(global.profanity_char) / 2;

for (var i = 0; i < _profanity_char_length; ++i)
{
    global.profanity_char_keys += global.profanity_char[i * 2];
}

global.profanity_extreme = [];
global.profanity_regular = [];

global.profanity_unique_length = [];

function init_scunthorpe(_type)
{
    static __init = function(_name, _directory)
    {
        var _buffer = buffer_load(_directory);
        
        var _data = string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n");
        
        var _unique_length = -1;
        var _unique_length_index = 0;
        
        var _length = array_length(_data);
        
        array_resize(global[$ _name], _length);
        
        var _profanity_length_previous = infinity;
        
        for (var i = 0; i < _length; ++i)
        {
            var _profanity = _data[i];
            var _profanity_length = string_length(_profanity);
            
            if (!array_contains(global.profanity_unique_length, _profanity_length))
            {
                array_push(global.profanity_unique_length, _profanity_length);
            }
            
            global[$ _name][@ i] = _profanity;
        }
        
        buffer_delete(_buffer);
    }
    
    if (!directory_exists($"scunthorpe/{_type}/"))
    {
        array_resize(global.profanity_extreme, 0);
        array_resize(global.profanity_regular, 0);
        
        exit;
    }
    
    array_resize(global.profanity_unique_length, 0);
    
    if (file_exists($"scunthorpe/{_type}/extreme.dic"))
    {
        __init("profanity_extreme", $"scunthorpe/{_type}/extreme.dic");
    }
    else
    {
        array_resize(global.profanity_extreme, 0);
    }
    
    if (file_exists($"scunthorpe/{_type}/regular.dic"))
    {
        __init("profanity_regular", $"scunthorpe/{_type}/regular.dic");
    }
    else
    {
        array_resize(global.profanity_regular, 0);
    }
    
    array_reverse_ext(global.profanity_unique_length);
    
    show_debug_message(global.profanity_unique_length);
}
