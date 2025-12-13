package backend.gameplay;

enum abstract GameplayPaths(String) from String to String {
    var START = './';
    var START_OLD = '.';

    var FIRST_CHOICE = './first_choice/';

    var FAKE_END = 'end';
}