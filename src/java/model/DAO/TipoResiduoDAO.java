package model.DAO;

import Config.ConectaBanco;
import java.sql.*;
import java.util.*;
import model.TipoResiduo;

public class TipoResiduoDAO {

    public boolean inserir(TipoResiduo obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "INSERT INTO TIPOS_RESIDUOS (nome_material, codigo_interno, densidade_kg_m3, valor_venda_estimado) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getNomeMaterial());
            ps.setString(2, obj.getCodigoInterno());
            ps.setDouble(3, obj.getDensidadeKgM3());
            ps.setDouble(4, obj.getValorVendaEstimado());
            ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao inserir em TIPOS_RESIDUOS: " + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<TipoResiduo> listarTodos() throws ClassNotFoundException {
        List<TipoResiduo> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM TIPOS_RESIDUOS";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                TipoResiduo obj = new TipoResiduo();
                obj.setIdTipo(rs.getInt("id_tipo"));
                obj.setNomeMaterial(rs.getString("nome_material"));
                obj.setCodigoInterno(rs.getString("codigo_interno"));
                obj.setDensidadeKgM3(rs.getDouble("densidade_kg_m3"));
                obj.setValorVendaEstimado(rs.getDouble("valor_venda_estimado"));
                lista.add(obj);
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao consultar TIPOS_RESIDUOS: " + ex.getMessage());
        }
        return lista;
    }

    // NOVO: buscar um tipo de resíduo pelo ID
    public TipoResiduo buscarPorId(int idTipo) throws ClassNotFoundException {
        Connection conn = null;
        TipoResiduo obj = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "SELECT * FROM TIPOS_RESIDUOS WHERE id_tipo = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idTipo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                obj = new TipoResiduo();
                obj.setIdTipo(rs.getInt("id_tipo"));
                obj.setNomeMaterial(rs.getString("nome_material"));
                obj.setCodigoInterno(rs.getString("codigo_interno"));
                obj.setDensidadeKgM3(rs.getDouble("densidade_kg_m3"));
                obj.setValorVendaEstimado(rs.getDouble("valor_venda_estimado"));
            }
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Erro ao buscar TIPOS_RESIDUOS por ID: " + ex.getMessage());
        }
        return obj;
    }

    // NOVO: atualizar um tipo de resíduo existente
    public boolean atualizar(TipoResiduo obj) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaBanco.conectar();
            String sql = "UPDATE TIPOS_RESIDUOS " +
                         "SET nome_material = ?, codigo_interno = ?, densidade_kg_m3 = ?, valor_venda_estimado = ? " +
                         "WHERE id_tipo = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, obj.getNomeMaterial());
            ps.setString(2, obj.getCodigoInterno());
            ps.setDouble(3, obj.getDensidadeKgM3());
            ps.setDouble(4, obj.getValorVendaEstimado());
            ps.setInt(5, obj.getIdTipo());

            int linhas = ps.executeUpdate();
            conn.close();
            return (linhas > 0);
        } catch (SQLException ex) {
            System.out.println("Erro ao atualizar TIPOS_RESIDUOS: " + ex.getMessage());
            return false;
        }
    }
}
