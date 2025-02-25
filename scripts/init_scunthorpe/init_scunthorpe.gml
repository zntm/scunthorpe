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

function init_scunthorpe(_type)
{
    var _dir_extreme = $"scunthorpe/{_type}/extreme.dic";
    var _dir_regular = $"scunthorpe/{_type}/regular.dic";
    
    if (!directory_exists($"scunthorpe/{_type}/")) || (!file_exists(_dir_extreme)) || (!file_exists(_dir_regular))
    {
        throw "Missing scunthorpe files";
    }
    
    var _buffer_extreme = buffer_load(_dir_extreme);
    
    global.profanity_extreme = array_unique(string_split(string_replace_all(buffer_read(_buffer_extreme, buffer_text), "\r", ""), "\n"));
    
    array_sort(global.profanity_extreme, sort_string_length);
    
    buffer_delete(_buffer_extreme);
    
    var _buffer_regular = buffer_load(_dir_regular);
    
    global.profanity_regular = array_unique(array_concat(global.profanity_extreme, string_split(string_replace_all(buffer_read(_buffer_regular, buffer_text), "\r", ""), "\n")));
    
    array_sort(global.profanity_regular, sort_string_length);
    
    buffer_delete(_buffer_regular);
}