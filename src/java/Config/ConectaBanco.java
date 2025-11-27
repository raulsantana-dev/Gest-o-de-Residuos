package Config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe utilitária para conexão com o banco MySQL.
 * Ajuste usuário e senha conforme seu ambiente.
 */
public class ConectaBanco {

    public static Connection conectar() throws ClassNotFoundException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver"); // mesmo driver usado em aula
            String url = "jdbc:mysql://localhost:3306/monitoramento_residuos";
            String user = "root";
            String password = "";
            conn = DriverManager.getConnection(url, user, password);
        } catch (SQLException ex) {
            System.out.println("Erro SQL na conexão: " + ex.getMessage());
        }
        return conn;
    }
}
