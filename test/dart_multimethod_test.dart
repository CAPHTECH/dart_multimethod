import 'package:dart_multimethod/dart_multimethod.dart';
import 'package:test/test.dart';

void main() {
  test('Multimethod', () {
    final area = Multimethod<A, String>((o) => o.name).when('first', (o) => '${o.name} square');
    expect(area(A('first')), 'first square');
    expect(() => area(A('second')), throwsArgumentError);
  });

  test('Multimethod with default', () {
    final area = Multimethod<A, String>((o) => o.name)
        .when('first', (o) => '${o.name} square')
        .defaultMethod((o) => '${o.name} area');
    expect(area(A('first')), 'first square');
    expect(area(A('second')), 'second area');
  });

  test('Multimethod with whenAny', () {
    final area = Multimethod<A, String>((o) => o.name)
        .when('first', (o) => '${o.name} square')
        .whenAny(['second', 'third'], (o) => '${o.name} area');
    expect(area(A('first')), 'first square');
    expect(area(A('second')), 'second area');
    expect(area(A('third')), 'third area');
    expect(() => area(A('fourth')), throwsArgumentError);
  });

  test('Multimethod with remove', () {
    final area = Multimethod<A, String>((o) => o.name)
        .when('first', (o) => '${o.name} square')
        .whenAny(['second', 'third'], (o) => '${o.name} area').remove('second');
    expect(area(A('first')), 'first square');
    expect(() => area(A('second')), throwsArgumentError);
    expect(area(A('third')), 'third area');
  });

  test('Multimethod without dispatch', () {
    final area = Multimethod<String, String>().when('first', (o) => '$o square');
    expect(area('first'), 'first square');
  });

  test('Multimethod call with Map', () {
    final area = Multimethod<Map<String, dynamic>, String>((o) => o['name'])
        .when('first', (o) => '${o['name']} square')
        .whenAny(['second', 'third'], (o) => '${o['name']} area');
    expect(area({'name': 'first'}), 'first square');
    expect(area({'name': 'second'}), 'second area');
    expect(area({'name': 'third'}), 'third area');
    expect(() => area({'name': 'fourth'}), throwsArgumentError);
  });
}

class A {
  A(this.name);
  final String name;
}
