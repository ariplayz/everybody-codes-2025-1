import 'package:everybody_codes_2025_1/everybody_codes_2025_1.dart';
import 'package:test/test.dart';

void main() {
  group('quest solvers', () {
	test('Part I clamps at list edges', () {
	  const input = 'Vyrdax,Drakzyph,Fyrryn,Elarzris\n\nR3,L2,R3,L1';
	  final notes = parseNotes(input);

	  expect(solvePart1(notes), 'Fyrryn');
	});

	test('Part II wraps on circular list', () {
	  const input = 'Vyrdax,Drakzyph,Fyrryn,Elarzris\n\nR3,L2,R3,L1';
	  final notes = parseNotes(input);

	  expect(solvePart2(notes), 'Elarzris');
	});

	test('Part III swaps top with referenced relative name', () {
	  const input = 'Vyrdax,Drakzyph,Fyrryn,Elarzris\n\nR3,L2,R3,L3';
	  final notes = parseNotes(input);

	  expect(solvePart3(notes), 'Drakzyph');
	});

	test('invalid move throws format exception', () {
	  const input = 'A,B,C\n\nR2,NOPE';
	  final notes = parseNotes(input);

	  expect(() => solvePart2(notes), throwsFormatException);
	});
  });
}

