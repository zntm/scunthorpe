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
    "0", "o",
    "#", "h"
];

global.profanity_extreme = [];
global.profanity_regular = [];

function init_scunthorpe(_type)
{
    static __init = function(_name, _directory)
    {
        var _buffer = buffer_load(_directory);
        
        var _data = array_unique(string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n"));
        
        array_sort(_data, sort_string_length);
        
        var _length = array_length(_data);
        
        array_resize(global[$ _name], _length)
        
        for (var i = 0; i < _length; ++i)
        {
            global[$ _name][@ i] = _data[i];
        }
        
        buffer_delete(_buffer);
    }
    
    if (!directory_exists($"scunthorpe/{_type}/"))
    {
        array_resize(global.profanity_extreme, 0);
        array_resize(global.profanity_regular, 0);
        
        exit;
    }
    
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
}