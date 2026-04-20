class Notes {
  Notes({required this.names, required this.moves});

  final List<String> names;
  final List<String> moves;
}

Notes parseNotes(String text) {
  final sections = text
	  .split(RegExp(r'\r?\n'))
	  .map((line) => line.trim())
	  .where((line) => line.isNotEmpty)
	  .toList();

  if (sections.length < 2) {
	throw FormatException('Expected names line and moves line.');
  }

  final names = sections[0]
	  .split(',')
	  .map((item) => item.trim())
	  .where((item) => item.isNotEmpty)
	  .toList();

  final moves = sections[1]
	  .split(',')
	  .map((item) => item.trim())
	  .where((item) => item.isNotEmpty)
	  .toList();

  if (names.isEmpty) {
	throw FormatException('Expected at least one name.');
  }

  return Notes(names: names, moves: moves);
}

int _parseOffset(String move) {
  final match = RegExp(r'^([LRlr])(\d+)$').firstMatch(move);
  if (match == null) {
	throw FormatException('Invalid move token: $move');
  }

  final direction = match.group(1)!.toUpperCase();
  final magnitude = int.parse(match.group(2)!);
  return direction == 'L' ? -magnitude : magnitude;
}

String solvePart1(Notes notes) {
  var position = 0;

  for (final move in notes.moves) {
	position += _parseOffset(move);
	if (position < 0) {
	  position = 0;
	} else if (position >= notes.names.length) {
	  position = notes.names.length - 1;
	}
  }

  return notes.names[position];
}

String solvePart2(Notes notes) {
  var position = 0;

  for (final move in notes.moves) {
	position += _parseOffset(move);
	position = ((position % notes.names.length) + notes.names.length) % notes.names.length;
  }

  return notes.names[position];
}

String solvePart3(Notes notes) {
  final names = List<String>.from(notes.names);

  for (final move in notes.moves) {
	final offset = _parseOffset(move);
	final targetIndex = ((offset % names.length) + names.length) % names.length;

	final top = names[0];
	names[0] = names[targetIndex];
	names[targetIndex] = top;
  }

  return names[0];
}

