import "user.dart";


class DataUser {

  final User owner;
  final int monitoriasMarcadas;        
  final int monitoriasPresentes;
  final int monitoriasAusentes;
  final int monitoriasCanceladas;
  final String phone;

  DataUser(
    {
      required this.owner, 
      required this.monitoriasMarcadas,
      required this.monitoriasPresentes,
      required this.monitoriasCanceladas,
      required this.monitoriasAusentes,
      required this.phone
    }
  );

}