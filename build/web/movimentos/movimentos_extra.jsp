<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Config.ConectaBanco"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório - Movimentação de Resíduos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Relatório - Movimentação de Resíduos</h1>

<form method="get" action="movimentos_extra.jsp">
    ID Ponto: 
    <input type="number" name="idPonto" value="<%= request.getParameter("idPonto") != null ? request.getParameter("idPonto") : "" %>">
    &nbsp;&nbsp;
    ID Tipo:
    <input type="number" name="idTipo" value="<%= request.getParameter("idTipo") != null ? request.getParameter("idTipo") : "" %>">
    &nbsp;&nbsp;
    <input type="submit" value="Filtrar">
</form>

<hr>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String erro = null;

    try {
        String idPontoStr = request.getParameter("idPonto");
        String idTipoStr = request.getParameter("idTipo");

        Integer idPonto = null;
        Integer idTipo = null;

        if (idPontoStr != null && idPontoStr.trim().length() > 0) {
            idPonto = Integer.parseInt(idPontoStr);
        }
        if (idTipoStr != null && idTipoStr.trim().length() > 0) {
            idTipo = Integer.parseInt(idTipoStr);
        }

        conn = ConectaBanco.conectar();

        String sql = "SELECT id_movimento, data_movimento, id_ponto, id_tipo, id_veiculo, id_destino, peso_kg, observacoes "
                   + "FROM MOVIMENTOS_RESIDUOS";

        boolean temWhere = false;
        if (idPonto != null) {
            sql += " WHERE id_ponto = ?";
            temWhere = true;
        }
        if (idTipo != null) {
            sql += (temWhere ? " AND " : " WHERE") + " id_tipo = ?";
        }

        sql += " ORDER BY data_movimento DESC";

        ps = conn.prepareStatement(sql);

        int i = 1;
        if (idPonto != null) {
            ps.setInt(i++, idPonto);
        }
        if (idTipo != null) {
            ps.setInt(i++, idTipo);
        }

        rs = ps.executeQuery();
%>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Data</th>
        <th>ID Ponto</th>
        <th>ID Tipo</th>
        <th>ID Veículo</th>
        <th>ID Destino</th>
        <th>Peso (kg)</th>
        <th>Obs.</th>
    </tr>
<%
    boolean tem = false;
    while (rs.next()) {
        tem = true;
%>
    <tr>
        <td><%= rs.getInt("id_movimento") %></td>
        <td><%= rs.getString("data_movimento") %></td>
        <td><%= rs.getInt("id_ponto") %></td>
        <td><%= rs.getInt("id_tipo") %></td>
        <td><%= rs.getInt("id_veiculo") %></td>
        <td><%= rs.getInt("id_destino") %></td>
        <td><%= rs.getDouble("peso_kg") %></td>
        <td><%= rs.getString("observacoes") %></td>
    </tr>
<%
    }
%>
</table>

<%
    if (!tem) {
%>
    <p>Nenhum registro encontrado para os filtros informados.</p>
<%
    }

    } catch (Exception e) {
        erro = e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception x) {}
        try { if (ps != null) ps.close(); } catch (Exception x) {}
        try { if (conn != null) conn.close(); } catch (Exception x) {}
    }

    if (erro != null) {
%>
    <p>Erro: <%= erro %></p>
<%
    }
%>

<p><a href="movimentos_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
