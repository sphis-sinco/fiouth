package backend.gameplay;

enum abstract GameplayPaths(String) from String to String
{
	var START = './';
	var START_OLD = '.';

	var FIRST_CHOICE = './first_choice/';

	var KEYPAD_SCENE = './first_choice/no/keypad/';

	var FAKE_END = 'end';
}
