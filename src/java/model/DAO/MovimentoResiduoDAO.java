package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.MovimentoResiduo;

public class MovimentoResiduoDAO {

    public boolean inserir(MovimentoResiduo m) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO MOVIMENTOS_RESIDUOS "
                    + "(data_movimento, id_ponto, id_tipo, id_veiculo, id_destino, peso_kg, observacoes) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, m.getDataMovimento());
            ps.setInt(2, m.getIdPonto());
            ps.setInt(3, m.getIdTipo());
            ps.setInt(4, m.getIdVeiculo());
            ps.setInt(5, m.getIdDestino());
            ps.setDouble(6, m.getPesoKg());
            ps.setString(7, m.getObservacoes());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro inserir MOVIMENTOS_RESIDUOS: " + e.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }

    public List<MovimentoResiduo> listarTodos() throws ClassNotFoundException {
        List<MovimentoResiduo> lista = new ArrayList<>();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM MOVIMENTOS_RESIDUOS ORDER BY id_movimento DESC");

            while (rs.next()) {
                MovimentoResiduo m = new MovimentoResiduo();
                m.setIdMovimento(rs.getInt("id_movimento"));
                m.setDataMovimento(rs.getString("data_movimento"));
                m.setIdPonto(rs.getInt("id_ponto"));
                m.setIdTipo(rs.getInt("id_tipo"));
                m.setIdVeiculo(rs.getInt("id_veiculo"));
                m.setIdDestino(rs.getInt("id_destino"));
                m.setPesoKg(rs.getDouble("peso_kg"));
                m.setObservacoes(rs.getString("observacoes"));
                lista.add(m);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar MOVIMENTOS_RESIDUOS: " + e.getMessage());

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (st != null) st.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }

        return lista;
    }

    public MovimentoResiduo buscarPorId(int id) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM MOVIMENTOS_RESIDUOS WHERE id_movimento = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                MovimentoResiduo m = new MovimentoResiduo();
                m.setIdMovimento(rs.getInt("id_movimento"));
                m.setDataMovimento(rs.getString("data_movimento"));
                m.setIdPonto(rs.getInt("id_ponto"));
                m.setIdTipo(rs.getInt("id_tipo"));
                m.setIdVeiculo(rs.getInt("id_veiculo"));
                m.setIdDestino(rs.getInt("id_destino"));
                m.setPesoKg(rs.getDouble("peso_kg"));
                m.setObservacoes(rs.getString("observacoes"));
                return m;
            }

        } catch (SQLException e) {
            System.out.println("Erro buscar MOVIMENTO_RESIDUO por ID: " + e.getMessage());

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }

        return null;
    }

    public boolean atualizar(MovimentoResiduo m) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "UPDATE MOVIMENTOS_RESIDUOS SET "
                    + "data_movimento = ?, id_ponto = ?, id_tipo = ?, id_veiculo = ?, "
                    + "id_destino = ?, peso_kg = ?, observacoes = ? "
                    + "WHERE id_movimento = ?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, m.getDataMovimento());
            ps.setInt(2, m.getIdPonto());
            ps.setInt(3, m.getIdTipo());
            ps.setInt(4, m.getIdVeiculo());
            ps.setInt(5, m.getIdDestino());
            ps.setDouble(6, m.getPesoKg());
            ps.setString(7, m.getObservacoes());
            ps.setInt(8, m.getIdMovimento());

            int linhas = ps.executeUpdate();
            return linhas > 0;

        } catch (SQLException e) {
            System.out.println("Erro atualizar MOVIMENTOS_RESIDUOS: " + e.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }
}
