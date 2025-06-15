function scunthorpe_substitute(_string)
{
    var _string_byte_length = string_byte_length(_string);
    
    var _substitutions        = global.__scunthorpe_substitutions;
    var _substitutions_length = array_length(_substitutions);
    
    var _buffer = buffer_create(_string_byte_length, buffer_fixed, 1);
    var _buffer_word = buffer_create(1, buffer_grow, 1);
    
    buffer_poke(_buffer, 0, buffer_text, _string);
    
    while (buffer_tell(_buffer) < _string_byte_length)
    {
        var _char_code = buffer_read(_buffer, buffer_u8);
        
        // Newline, carriage return and space, we can skip as they are merely whitespace.
        if (_char_code == 0x0A) || (_char_code == 0x0D) || (_char_code == 0x20) continue;
        
        var _start = buffer_tell(_buffer) - 1;
        
        buffer_seek(_buffer_word, buffer_seek_start, 0);
        
        // Newline, carriage return and space, we don't want these! The rest are fine.
        while(((_char_code != 0x0A) && (_char_code != 0x0D) && (_char_code != 0x20)) && (buffer_tell(_buffer) != _string_byte_length))
        {
            var _ = buffer_read(_buffer, buffer_u8);
        }
        
        var _end = buffer_tell(_buffer) - 1;
        
        buffer_copy(_buffer, _start, _end, _buffer_word, 0);
        
        buffer_seek(_buffer_word, buffer_seek_start, _end);
        
        // NOTE: 0 is a null byte used for reading the string.
        buffer_write(_buffer_word, buffer_u8, 0);
        
        buffer_seek(_buffer_word, buffer_seek_start, 0);
        
        var _word = buffer_read(_buffer_word, buffer_text);
        
        for (var i = 0; i < _substitutions_length; ++i)
        {
            var _substitution = _substitutions[i];
            
            var _a = _substitution[0];
            var _b = _substitution[1];
            
            
            // if (string_pos(_a, _string) <= 0) continue;
            
            // _string = string_replace_all(_string, _a, _b + string_repeat(SCUNTHORPE_OFFSET_PLACEHOLDER, string_length(_a) - string_length(_b)));
            
        }
    }
    
    
    
    show_debug_message(_string);
    
    /*

    
    for (var i = 0; i < _substitutions_length; ++i)
    {
        var _substitution = _substitutions[i];
        
        var _a = _substitution[0];
        var _b = _substitution[1];
        
        
        // if (string_pos(_a, _string) <= 0) continue;
        
        // _string = string_replace_all(_string, _a, _b + string_repeat(SCUNTHORPE_OFFSET_PLACEHOLDER, string_length(_a) - string_length(_b)));
        
    }
    */
    buffer_delete(_buffer);
    buffer_delete(_buffer_word);
    
    return _string;
}

/*
 * var _str = "Hello, World!");
var _byteLen = string_byte_length(_str);
var _buff = buffer_create(_byteLen, buffer_fixed, 1);
var _buffCopy = buffer_create(1, buffer_grow, 1);
// We poke to prevent write/seek
buffer_poke(_buff, 0, buffer_text, _str);

while(buffer_tell(_buff) < _byteLen) {
  var _charCode = buffer_read(_buff, buffer_u8); // Assuming Ascii
  
  // Newline, carriage return and space, we can skip. As they are merely whitespace
  if (_charCode == 0x0A || _charCode == 0x0D || _charCode == 0x20) {
     continue;
  }

  var _startPos = buffer_tell(_buff);
  buffer_seek(_buffCopy, buffer_seek_start, 0);
 
  // Newline, carriage return and space, we don't want these! The rest are fine.
  while(_charCode == 0x0A || _charCode == 0x0D || _charCode == 0x20)) {
    var _charCode = buffer_read(_buff, buffer_u8); // Assuming Ascii
  }
  var _endPos = buffer_tell(_buff)-1;
  buffer_copy(_buff, _startPos, _endPos, _buffCopy, 0);
  buffer_seek(_buffCopy, buffer_seek_start, _endPos); // Seek to end
  buffer_write(_buffCopy, buffer_u8, 0); // Null byte, we need this for reading a string
  buffer_seek(_buffCopy, buffer_seek_start, 0); // Seek back to start to prepare for reading
  var _word = buffer_read(_buffCopy, buffer_text);
  show_debug_message(_word);
}

buffer_delete(_buff);
buffer_delete(_buffCopy);