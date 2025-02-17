function string_filter(_string, _function)
{
	var _filtered_string = "";
	
	var _length = string_length(_string);
	
	for (var i = 1; i <= _length; ++i)
	{
		var _char = string_char_at(_string, i);
		
		if (!_function(_char)) continue;
		
		_filtered_string += _char;
	}
	
	return _filtered_string;
}