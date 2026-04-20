import 'dart:io';

Future<void> main(List<String> arguments) async {
  final path = arguments.isNotEmpty ? arguments.first : 'input.txt';
  final text = await File(path).readAsString();
  print(text);

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

  int position = 0;
  for (final move in moves) {
    final match = RegExp(r'^([LRlr])(\d+)$').firstMatch(move);
    if (match == null) {
      throw FormatException('Invalid move token: $move');
    }

    final direction = match.group(1)!.toUpperCase();
    final magnitude = int.parse(match.group(2)!);
    final distance = direction == 'L' ? -magnitude : magnitude;

    position += distance;
    if (position < 0) {
      position = 0;
    } else if (position >= names.length) {
      position = names.length - 1;
    }
  }

  print(position);
  print(names[position]);

}
