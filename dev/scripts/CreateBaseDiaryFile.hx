package dev.scripts;

import sys.io.File;

class CreateBaseDiaryFile
{
	static var customdayths = [1 => 'st', 2 => 'nd', 3 => 'rd',];

	static var months = [
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December'
	];

	public static function main()
	{
		var curDate = Date.now();

		var month = curDate.getMonth() + 1;
		trace('month: ' + month);

		var day = curDate.getDate();
		trace('day: ' + day);

		var year = curDate.getFullYear();
		trace('year: ' + year);

		var hour = curDate.getHours();
		trace('hour: ' + hour);

		var aorp = (hour >= 12) ? 'p' : 'a';

		if (aorp == 'p')
			hour -= 12;
		trace('aorp: ' + aorp);

		var filename = '${(month < 10) ? '0' : ''}$month.${(day < 10) ? '0' : ''}$day.$year.${(hour < 10) ? '0' : ''}${hour}${aorp}.md';

		trace('filename: ' + filename);

		File.saveContent('dev/diary/' + filename, '# ${months[month - 1]} $day${(!customdayths.exists(day) ? 'th' : customdayths.get(day))}, $year : ${hour}${aorp}m');
	}
}
