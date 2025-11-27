package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.DestinoFinal;

public class DestinoFinalDAO {

    public boolean inserir(DestinoFinal obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO DESTINO_FINAL (nome_local, tipo_local, endereco, capacidade_diaria) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getNomeLocal());
            ps.setString(2, obj.getTipoLocal());
            ps.setString(3, obj.getEndereco());
            ps.setDouble(4, obj.getCapacidadeDiaria());
            ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em DESTINO_FINAL: " + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<DestinoFinal> listarTodos() throws ClassNotFoundException {
        List<DestinoFinal> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM DESTINO_FINAL";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                DestinoFinal obj = new DestinoFinal();
                obj.setIdDestino(rs.getInt("id_destino"));
                obj.setNomeLocal(rs.getString("nome_local"));
                obj.setTipoLocal(rs.getString("tipo_local"));
                obj.setEndereco(rs.getString("endereco"));
                obj.setCapacidadeDiaria(rs.getDouble("capacidade_diaria"));
                lista.add(obj);
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar DESTINO_FINAL: " + ex.getMessage());
        }
        return lista;
    }
}