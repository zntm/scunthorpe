global.__scunthorpe_censor_char = "*";
global.__scunthorpe_substitutions = [];

global.__scunthorpe_extreme = [];
global.__scunthorpe_extreme_group = [];

global.__scunthorpe_regular = [];
global.__scunthorpe_regular_group = [];

function init_scunthorpe(_directory)
{
    static __init = function(_variable, _variable_length, _directory)
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
        
        for (var i = 0; i < _length; ++i)
        {
            var _word = _data[i];
            var _word_length = string_length(_word);
            
            _variable[@ i] = _word;
        }
        
        array_sort(_variable, __sort);
        
        for (var i = 0; i < _length; ++i)
        {
            var _word = _variable[@ i];
            var _word_length = string_length(_word);
            
            if (array_length(_variable_length) < _word_length)
            {
                _variable_length[@ _word_length] = 0;
            }
            
            ++_variable_length[@ _word_length];
        }
        
        buffer_delete(_buffer);
    }
    
    if (directory_exists(_directory))
    {
        array_resize(global.__scunthorpe_substitutions, 0);
        
        if (file_exists($"{_directory}/data.json"))
        {
            static __sort_subsitution = function(_a, _b)
            {
                return string_length(_b[0]) - string_length(_a[0]);
            }
            
            var _index = 0;
            
            var _buffer = buffer_load($"{_directory}/data.json");
            
            var _json = json_parse(buffer_read(_buffer, buffer_text));
            
            var _json_substitution = _json.substitution;
            
            var _names  = struct_get_names(_json_substitution);
            var _length = array_length(_names);
            
            for (var i = 0; i < _length; ++i)
            {
                var _name = _names[i];
                var _name_length = string_length(_name);
                
                var _data = _json_substitution[$ _name];
                var _data_length = array_length(_data);
                
                for (var j = 0; j < _data_length; ++j)
                {
                    var _key = _data[j];
                    
                    global.__scunthorpe_substitutions[@ _index++] = [ _key, _name, string_length(_key), _name_length ];
                }
            }
            
            global.__scunthorpe_censor_char = _json.censor;
            
            array_sort(global.__scunthorpe_substitutions, __sort_subsitution);
            
            buffer_delete(_buffer);
            
            delete _json;
        }
        
        if (file_exists($"{_directory}/extreme.dic"))
        {
            __init(global.__scunthorpe_extreme, global.__scunthorpe_extreme_group, $"{_directory}/extreme.dic");
        }
        else
        {
            array_resize(global.__scunthorpe_extreme, 0);
            array_resize(global.__scunthorpe_extreme_group, 0);
        }
        
        if (file_exists($"{_directory}/regular.dic"))
        {
            __init(global.__scunthorpe_regular, global.__scunthorpe_regular_group, $"{_directory}/regular.dic");
        }
        else
        {
            array_resize(global.__scunthorpe_regular, 0);
            array_resize(global.__scunthorpe_regular_group, 0);
        }
    }
    else
    {
        array_resize(global.__scunthorpe_substitutions, 0);
        
        array_resize(global.__scunthorpe_extreme, 0);
        array_resize(global.__scunthorpe_extreme_group, 0);
        
        array_resize(global.__scunthorpe_regular, 0);
        array_resize(global.__scunthorpe_regular_group, 0);
    }
}
