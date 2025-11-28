package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.VeiculoRota;

public class VeiculoRotaDAO {

    public boolean inserir(VeiculoRota v) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO VEICULOS_ROTAS (placa, capacidade_m3, rota_nome, rota_descricao, dia_semana_rota) "
                       + "VALUES (?, ?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, v.getPlaca());
            ps.setDouble(2, v.getCapacidadeM3());
            ps.setString(3, v.getRotaNome());
            ps.setString(4, v.getRotaDescricao());
            ps.setString(5, v.getDiaSemanaRota());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro inserir veículo/rota: " + e.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }

    public List<VeiculoRota> listarTodos() throws ClassNotFoundException {
        List<VeiculoRota> lista = new ArrayList<>();

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM VEICULOS_ROTAS ORDER BY id_veiculo");

            while (rs.next()) {
                VeiculoRota v = new VeiculoRota();
                v.setIdVeiculo(rs.getInt("id_veiculo"));
                v.setPlaca(rs.getString("placa"));
                v.setCapacidadeM3(rs.getDouble("capacidade_m3"));
                v.setRotaNome(rs.getString("rota_nome"));
                v.setRotaDescricao(rs.getString("rota_descricao"));
                v.setDiaSemanaRota(rs.getString("dia_semana_rota"));

                lista.add(v);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao listar veículos/rotas: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (st != null) st.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }

        return lista;
    }

    public VeiculoRota buscarPorId(int id) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM VEICULOS_ROTAS WHERE id_veiculo = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                VeiculoRota v = new VeiculoRota();
                v.setIdVeiculo(rs.getInt("id_veiculo"));
                v.setPlaca(rs.getString("placa"));
                v.setCapacidadeM3(rs.getDouble("capacidade_m3"));
                v.setRotaNome(rs.getString("rota_nome"));
                v.setRotaDescricao(rs.getString("rota_descricao"));
                v.setDiaSemanaRota(rs.getString("dia_semana_rota"));
                return v;
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar veículo/rota por ID: " + e.getMessage());

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }

        return null;
    }

    public boolean atualizar(VeiculoRota v) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "UPDATE VEICULOS_ROTAS SET placa = ?, capacidade_m3 = ?, rota_nome = ?, rota_descricao = ?, dia_semana_rota = ? "
                       + "WHERE id_veiculo = ?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, v.getPlaca());
            ps.setDouble(2, v.getCapacidadeM3());
            ps.setString(3, v.getRotaNome());
            ps.setString(4, v.getRotaDescricao());
            ps.setString(5, v.getDiaSemanaRota());
            ps.setInt(6, v.getIdVeiculo());

            int linhas = ps.executeUpdate();
            return linhas > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar veículo/rota: " + e.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }
}
