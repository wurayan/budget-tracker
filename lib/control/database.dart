import 'package:mysql_client/mysql_client.dart';

MySQLConnectionPool pool = MySQLConnectionPool(
  host: host,
  port: port,
  userName: userName,
  password: password,
  maxConnections: maxConnections,
);
