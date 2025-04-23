import "user.dart";


class DataUser {

  final User owner;
  int monitoriasMarcadas;        
  int monitoriasPresentes;
  int monitoriasAusentes;
  int monitoriasCanceladas;
  final String phone;

  DataUser(
    {
      required this.owner, 
      this.monitoriasMarcadas = 0,
      this.monitoriasPresentes = 0,
      this.monitoriasCanceladas = 0,
      this.monitoriasAusentes = 0,
      required this.phone
    }
  );

}