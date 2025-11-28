package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.DestinoFinal;

public class DestinoFinalDAO {

    public boolean inserir(DestinoFinal d) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO DESTINO_FINAL (nome_local, tipo_local, endereco, capacidade_diaria) "
                       + "VALUES (?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, d.getNomeLocal());
            ps.setString(2, d.getTipoLocal());
            ps.setString(3, d.getEndereco());
            ps.setDouble(4, d.getCapacidadeDiaria());

            ps.executeUpdate();
            return true;

        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em DESTINO_FINAL: " + ex.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }

    public List<DestinoFinal> listarTodos() throws ClassNotFoundException {
        List<DestinoFinal> lista = new ArrayList<>();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM DESTINO_FINAL ORDER BY id_destino";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                DestinoFinal d = new DestinoFinal();
                d.setIdDestino(rs.getInt("id_destino"));
                d.setNomeLocal(rs.getString("nome_local"));
                d.setTipoLocal(rs.getString("tipo_local"));
                d.setEndereco(rs.getString("endereco"));
                d.setCapacidadeDiaria(rs.getDouble("capacidade_diaria"));
                lista.add(d);
            }

        } catch (SQLException ex) {
            System.out.println("Erro ao consultar DESTINO_FINAL: " + ex.getMessage());

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (stmt != null) stmt.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
        return lista;
    }

    public DestinoFinal buscarPorId(int id) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM DESTINO_FINAL WHERE id_destino = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();
            if (rs.next()) {
                DestinoFinal d = new DestinoFinal();
                d.setIdDestino(rs.getInt("id_destino"));
                d.setNomeLocal(rs.getString("nome_local"));
                d.setTipoLocal(rs.getString("tipo_local"));
                d.setEndereco(rs.getString("endereco"));
                d.setCapacidadeDiaria(rs.getDouble("capacidade_diaria"));
                return d;
            }

        } catch (SQLException ex) {
            System.out.println("Erro ao buscar DESTINO_FINAL por ID: " + ex.getMessage());

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception x) {}
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }

        return null;
    }

    public boolean atualizar(DestinoFinal d) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConectaBanco.conectar();
            String sql = "UPDATE DESTINO_FINAL SET "
                       + "nome_local = ?, tipo_local = ?, endereco = ?, capacidade_diaria = ? "
                       + "WHERE id_destino = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, d.getNomeLocal());
            ps.setString(2, d.getTipoLocal());
            ps.setString(3, d.getEndereco());
            ps.setDouble(4, d.getCapacidadeDiaria());
            ps.setInt(5, d.getIdDestino());

            int linhas = ps.executeUpdate();
            return (linhas > 0);

        } catch (SQLException ex) {
            System.out.println("Erro ao atualizar DESTINO_FINAL: " + ex.getMessage());
            return false;

        } finally {
            try { if (ps != null) ps.close(); } catch (Exception x) {}
            try { if (conn != null) conn.close(); } catch (Exception x) {}
        }
    }
}
