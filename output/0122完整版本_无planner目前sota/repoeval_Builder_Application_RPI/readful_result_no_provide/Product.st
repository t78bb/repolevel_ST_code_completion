VAR
// Index variable for iteration
  i : INT;
END_VAR

// Static initialization of parts as dynamic assignment is not possible without specifications
CASE i OF
  1: mainPart := 'DefaultMainPart'; // Set to static/default value
  2: part1 := 'DefaultPart1';      // Set to static/default value
  3: part2 := 'DefaultPart2';      // Set to static/default value
  4: part3 := 'DefaultPart3';      // Set to static/default value
END_CASE;
END_FUNCTION_BLOCK