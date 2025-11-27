package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.MovimentoResiduo;

public class MovimentoResiduoDAO {

    public boolean inserir(MovimentoResiduo obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO MOVIMENTOS_RESIDUOS (data_movimento, id_ponto, id_tipo, id_veiculo, id_destino, peso_kg, observacoes) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getDataMovimento());
            ps.setInt(2, obj.getIdPonto());
            ps.setInt(3, obj.getIdTipo());
            ps.setInt(4, obj.getIdVeiculo());
            ps.setInt(5, obj.getIdDestino());
            ps.setDouble(6, obj.getPesoKg());
            ps.setString(7, obj.getObservacoes());
            ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em MOVIMENTOS_RESIDUOS: " + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<MovimentoResiduo> listarTodos() throws ClassNotFoundException {
        List<MovimentoResiduo> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM MOVIMENTOS_RESIDUOS";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                MovimentoResiduo obj = new MovimentoResiduo();
                obj.setIdMovimento(rs.getInt("id_movimento"));
                obj.setDataMovimento(rs.getString("data_movimento"));
                obj.setIdPonto(rs.getInt("id_ponto"));
                obj.setIdTipo(rs.getInt("id_tipo"));
                obj.setIdVeiculo(rs.getInt("id_veiculo"));
                obj.setIdDestino(rs.getInt("id_destino"));
                obj.setPesoKg(rs.getDouble("peso_kg"));
                obj.setObservacoes(rs.getString("observacoes"));
                lista.add(obj);
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar MOVIMENTOS_RESIDUOS: " + ex.getMessage());
        }
        return lista;
    }
}