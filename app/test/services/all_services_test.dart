import "package:app/models/days.dart";
import "package:app/models/disciplinas.dart";
import "package:app/models/matricula.dart";
import "package:app/services/disciplina_service.dart";
import "package:app/services/matricula_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "all_services_test.mocks.dart";

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
])
void main() {
  // Initialize the mock objects
  late MockCollectionReference collectionReference;
  late MockQuerySnapshot querySnapshot;
  late MockQueryDocumentSnapshot queryDocumentSnapshot001;
  late MockQueryDocumentSnapshot queryDocumentSnapshot002;
  late MockFirebaseFirestore firestore;
  late MockDocumentReference documentReference;

  setUpAll(() {
    firestore = MockFirebaseFirestore();
  });

  group("DisciplinaService", () {
    late List<Disciplina> expectedDisciplina;
    late String idDisciplina;
    late String collectionDisciplina;
    late String collectionDays;
    late List<Days> expectedDays;
    late MockCollectionReference daysCollection;

    setUp(() {
      collectionReference = MockCollectionReference();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();
      documentReference = MockDocumentReference();
      querySnapshot = MockQuerySnapshot();
    });

    test("getDisciplinasIDs returns a list of Disciplinas", () {
      queryDocumentSnapshot002 = MockQueryDocumentSnapshot();
      collectionDisciplina = 'disciplinas';
      expectedDisciplina = [
        Disciplina(
            id: '202213313611',
            nome: 'Mathematics',
            monitor: 'John Doe',
            campus: 'Main Campus'),
        Disciplina(
            id: '202213313612',
            nome: 'Physics',
            monitor: 'Jane Smith',
            campus: 'Main Campus'),
      ];

      when(queryDocumentSnapshot001.data()).thenReturn({
        'id': '202213313611',
        'nome': 'Mathematics',
        'monitor': 'John Doe',
        'campus': 'Main Campus'
      });
      when(queryDocumentSnapshot002.data()).thenReturn({
        'id': '202213313612',
        'nome': 'Physics',
        'monitor': 'Jane Smith',
        'campus': 'Main Campus'
      });
      when(querySnapshot.docs)
          .thenReturn([queryDocumentSnapshot001, queryDocumentSnapshot002]);

      when(collectionReference.get()).thenAnswer((_) async {
        return Future.value(querySnapshot);
      });
      when(firestore.collection(collectionDisciplina))
          .thenReturn(collectionReference);

      DisciplinaService.getDisciplinas(firestore: firestore)
          .then((disciplinas) {
        expect(disciplinas, isA<List<Disciplina>>());
        expect(disciplinas.length, equals(expectedDisciplina.length));
        for (int i = 0; i < disciplinas.length; i++) {
          expect(disciplinas[i].id, equals(expectedDisciplina[i].id));
          expect(disciplinas[i].nome, equals(expectedDisciplina[i].nome));
          expect(disciplinas[i].monitor, equals(expectedDisciplina[i].monitor));
          expect(disciplinas[i].campus, equals(expectedDisciplina[i].campus));
        }
      });
    });

    test("getDaysOfDisciplineId", () {
      collectionDays = 'days';
      idDisciplina = '202213313611';

      Map<String, dynamic> hours = {
        "end": "12",
        "start": "7",
        "isActive": true,
      };

      expectedDays = [
        Days(days: 'Monday', hours: hours),
      ];

      daysCollection = MockCollectionReference();
      querySnapshot = MockQuerySnapshot();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();

      when(queryDocumentSnapshot001.id).thenReturn('Monday');
      when(queryDocumentSnapshot001.data()).thenReturn({
        'end': '12',
        'start': '7',
        'isActive': true,
      });
      when(querySnapshot.docs).thenReturn([queryDocumentSnapshot001]);
      when(daysCollection.get()).thenAnswer((_) async {
        return Future.value(querySnapshot);
      });

      when(queryDocumentSnapshot001.data()).thenReturn(hours);
      when(queryDocumentSnapshot001.id).thenReturn('Monday');
      when(documentReference.collection(collectionDays))
          .thenReturn(daysCollection);

      when(collectionReference.doc(idDisciplina)).thenReturn(documentReference);
      when(firestore.collection(collectionDisciplina))
          .thenReturn(collectionReference);

      DisciplinaService.getDaysOfDisciplineId(firestore, idDisciplina)
          .then((days) {
        expect(days, isA<List<Days>>());
        expect(days.length, expectedDays.length);
        for (int i = 0; i < days.length; i++) {
          expect(days[i].days, equals(expectedDays[i].days));
          expect(days[i].hours, equals(expectedDays[i].hours));
        }
      });
    });
  });

  group("MatriculaService", () {
    setUp(() {
      collectionReference = MockCollectionReference();
      queryDocumentSnapshot001 = MockQueryDocumentSnapshot();
      documentReference = MockDocumentReference();
      querySnapshot = MockQuerySnapshot();
    });
    test("getDatamatriculaByNumberMatricula", () {
      String matricula = "202213313611";
      String collectionMatricula = "matriculas";

      Disciplina disciplina = Disciplina(
          id: '202213313611',
          nome: 'Arquitetura de Computadores',
          monitor: 'Daniel Passos',
          campus: 'Zona Oeste');

      Matricula matriculaData = Matricula(
          campus: "Zona Oeste",
          disciplinas: [disciplina],
          matricula: matricula);

      when(queryDocumentSnapshot001.data()).thenReturn({
        "matricula": matricula.toString(),
        "disciplinas": [disciplina.toMap()],
        "campus": "Zona Oeste"
      });
      when(documentReference.get()).thenAnswer((_) async {
        return Future.value(queryDocumentSnapshot001);
      });
      when(collectionReference.doc(matricula)).thenReturn(documentReference);
      when(firestore.collection(collectionMatricula))
          .thenReturn(collectionReference);
      MatriculaService.getDataMatriculaByNumberMatricula(
              firestore: firestore, matricula: matricula)
          .then((value) {
        expect(value.matricula, matriculaData.matricula);
        expect(value.campus, matriculaData.campus);
        for (int index = 0; index < matriculaData.disciplinas.length; index++) {
          expect(
              value.disciplinas[index].id, matriculaData.disciplinas[index].id);
        }
      });
    });
  });
}
