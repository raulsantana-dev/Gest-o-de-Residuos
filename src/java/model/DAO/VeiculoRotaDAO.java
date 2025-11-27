package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.VeiculoRota;

public class VeiculoRotaDAO {

    public boolean inserir(VeiculoRota obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO VEICULOS_ROTAS (placa, capacidade_m3, rota_nome, rota_descricao, dia_semana_rota) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getPlaca());
            ps.setDouble(2, obj.getCapacidadeM3());
            ps.setString(3, obj.getRotaNome());
            ps.setString(4, obj.getRotaDescricao());
            ps.setString(5, obj.getDiaSemanaRota());
            ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em VEICULOS_ROTAS: " + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<VeiculoRota> listarTodos() throws ClassNotFoundException {
        List<VeiculoRota> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM VEICULOS_ROTAS";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                VeiculoRota obj = new VeiculoRota();
                obj.setIdVeiculo(rs.getInt("id_veiculo"));
                obj.setPlaca(rs.getString("placa"));
                obj.setCapacidadeM3(rs.getDouble("capacidade_m3"));
                obj.setRotaNome(rs.getString("rota_nome"));
                obj.setRotaDescricao(rs.getString("rota_descricao"));
                obj.setDiaSemanaRota(rs.getString("dia_semana_rota"));
                lista.add(obj);
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar VEICULOS_ROTAS: " + ex.getMessage());
        }
        return lista;
    }
}