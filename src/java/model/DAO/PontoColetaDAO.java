package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.PontoColeta;

public class PontoColetaDAO {

    public boolean inserir(PontoColeta obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO PONTOS_COLETA (nome_ponto, endereco, capacidade_kg, status, frequencia_coleta_dias) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getNomePonto());
            ps.setString(2, obj.getEndereco());
            ps.setDouble(3, obj.getCapacidadeKg());
            ps.setString(4, obj.getStatus());
            ps.setInt(5, obj.getFrequenciaColetaDias());
            ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em PONTOS_COLETA: " + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<PontoColeta> listarTodos() throws ClassNotFoundException {
        List<PontoColeta> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM PONTOS_COLETA";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                PontoColeta obj = new PontoColeta();
                obj.setId(rs.getInt("id"));
                obj.setNomePonto(rs.getString("nome_ponto"));
                obj.setEndereco(rs.getString("endereco"));
                obj.setCapacidadeKg(rs.getDouble("capacidade_kg"));
                obj.setStatus(rs.getString("status"));
                obj.setFrequenciaColetaDias(rs.getInt("frequencia_coleta_dias"));
                lista.add(obj);
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar PONTOS_COLETA: " + ex.getMessage());
        }
        return lista;
    }
}