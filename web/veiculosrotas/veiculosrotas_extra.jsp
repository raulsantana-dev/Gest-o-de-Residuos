<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Config.ConectaBanco"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório de Veículos / Rotas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Relatório de Veículos / Rotas</h1>

<form method="get" action="veiculosrotas_extra.jsp">
    Placa: 
    <input type="text" name="placa" value="<%= request.getParameter("placa") != null ? request.getParameter("placa") : "" %>">
    &nbsp;&nbsp;
    Dia da semana:
    <input type="text" name="diaSemanaRota" value="<%= request.getParameter("diaSemanaRota") != null ? request.getParameter("diaSemanaRota") : "" %>">
    &nbsp;&nbsp;
    <input type="submit" value="Buscar">
</form>

<hr>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String erro = null;

    try {
        String placa = request.getParameter("placa");
        String dia = request.getParameter("diaSemanaRota");

        conn = ConectaBanco.conectar();

        // ajuste o nome da VIEW aqui
        String sql = "SELECT id_veiculo, placa, capacidade_m3, rota_nome, rota_descricao, dia_semana_rota " +
                     "FROM VW_VEICULOS_ROTAS";

        boolean temWhere = false;
        if (placa != null && placa.trim().length() > 0) {
            sql += " WHERE placa LIKE ?";
            temWhere = true;
        }
        if (dia != null && dia.trim().length() > 0) {
            sql += (temWhere ? " AND " : " WHERE") + " dia_semana_rota = ?";
        }

        ps = conn.prepareStatement(sql);

        int i = 1;
        if (placa != null && placa.trim().length() > 0) {
            ps.setString(i++, "%" + placa.trim() + "%");
        }
        if (dia != null && dia.trim().length() > 0) {
            ps.setString(i++, dia.trim());
        }

        rs = ps.executeQuery();

%>
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Placa</th>
        <th>Capacidade (m³)</th>
        <th>Rota</th>
        <th>Descrição</th>
        <th>Dia da semana</th>
    </tr>
<%
    boolean tem = false;
    while (rs.next()) {
        tem = true;
%>
    <tr>
        <td><%= rs.getInt("id_veiculo") %></td>
        <td><%= rs.getString("placa") %></td>
        <td><%= rs.getDouble("capacidade_m3") %></td>
        <td><%= rs.getString("rota_nome") %></td>
        <td><%= rs.getString("rota_descricao") %></td>
        <td><%= rs.getString("dia_semana_rota") %></td>
    </tr>
<%
    }
%>
</table>
<%
    if (!tem) {
%>
    <p>Nenhum registro encontrado.</p>
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

<p><a href="veiculosrotas_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
