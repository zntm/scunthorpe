global.__scunthorpe_substitutions = [];

global.__scunthorpe_extreme = [];
global.__scunthorpe_regular = [];

function init_scunthorpe(_directory)
{
    static __init = function(_variable, _directory)
    {
        static __sort = function(_a, _b)
        {
            return string_length(_b) - string_length(_a);
        }
        
        var _buffer = buffer_load(_directory);
        
        var _data = string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n");
        
        var _unique_length = -1;
        var _unique_length_index = 0;
        
        var _length = array_length(_data);
        
        array_resize(_variable, _length);
        
        var _substitutions        = global.__scunthorpe_substitutions;
        var _substitutions_length = array_length(_substitutions);
        
        for (var i = 0; i < _length; ++i)
        {
            _variable[@ i] = _data[i];
        }
        
        array_sort(_variable, __sort);
        
        buffer_delete(_buffer);
    }
    
    if (directory_exists(_directory))
    {
        array_resize(global.__scunthorpe_substitutions, 0);
        
        if (file_exists($"{_directory}/substitution.json"))
        {
            static __sort_subsitution = function(_a, _b)
            {
                return string_length(_b[0]) - string_length(_a[0]);
            }
            
            var _index = 0;
            
            var _buffer = buffer_load($"{_directory}/substitution.json");
            
            var _json = json_parse(buffer_read(_buffer, buffer_text));
            
            var _names  = struct_get_names(_json);
            var _length = array_length(_names);
            
            for (var i = 0; i < _length; ++i)
            {
                var _name = _names[i];
                var _data = _json[$ _name];
                
                var _length2 = array_length(_data);
                
                for (var j = 0; j < _length2; ++j)
                {
                    global.__scunthorpe_substitutions[@ _index++] = [ _data[j], _name ];
                }
            }
            
            array_sort(global.__scunthorpe_substitutions, __sort_subsitution);
            
            buffer_delete(_buffer);
        }
        
        if (file_exists($"{_directory}/extreme.dic"))
        {
            __init(global.__scunthorpe_extreme, $"{_directory}/extreme.dic");
        }
        else
        {
            array_resize(global.__scunthorpe_extreme, 0);
        }
        
        if (file_exists($"{_directory}/regular.dic"))
        {
            __init(global.__scunthorpe_regular, $"{_directory}/regular.dic");
        }
        else
        {
            array_resize(global.__scunthorpe_regular, 0);
        }
    }
    else
    {
        array_resize(global.__scunthorpe_substitutions, 0);
        
        array_resize(global.__scunthorpe_extreme, 0);
        array_resize(global.__scunthorpe_regular, 0);
    }
}
