import 'dart:io';
import 'package:everybody_codes_2025_1/everybody_codes_2025_1.dart';

Future<void> main(List<String> arguments) async {
  final path = arguments.isNotEmpty ? arguments.first : 'input.txt';
  final text = await File(path).readAsString();

  final notes = parseNotes(text);
  print('Part I: ${solvePart1(notes)}');
  print('Part II: ${solvePart2(notes)}');
  print('Part III: ${solvePart3(notes)}');

}
