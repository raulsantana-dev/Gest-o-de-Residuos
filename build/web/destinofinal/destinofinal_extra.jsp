<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Config.ConectaBanco"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório - Destino Final</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<h1>Relatório - Destino Final</h1>

<form method="get" action="destinofinal_extra.jsp">
    Tipo de local: 
    <input type="text" name="tipoLocal" value="<%= request.getParameter("tipoLocal") != null ? request.getParameter("tipoLocal") : "" %>">
    &nbsp;&nbsp;
    Capacidade mínima (kg/dia):
    <input type="number" step="0.01" name="capacidadeMin" value="<%= request.getParameter("capacidadeMin") != null ? request.getParameter("capacidadeMin") : "" %>">
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
        String tipoLocal = request.getParameter("tipoLocal");
        String capacidadeMinStr = request.getParameter("capacidadeMin");

        Double capacidadeMin = null;
        if (capacidadeMinStr != null && capacidadeMinStr.trim().length() > 0) {
            capacidadeMin = Double.parseDouble(capacidadeMinStr.replace(",", "."));
        }

        conn = ConectaBanco.conectar();

        String sql = "SELECT id_destino, nome_local, tipo_local, endereco, capacidade_diaria "
                   + "FROM DESTINO_FINAL";

        boolean temWhere = false;
        if (tipoLocal != null && tipoLocal.trim().length() > 0) {
            sql += " WHERE tipo_local LIKE ?";
            temWhere = true;
        }
        if (capacidadeMin != null) {
            sql += (temWhere ? " AND " : " WHERE") + " capacidade_diaria >= ?";
        }

        sql += " ORDER BY nome_local";

        ps = conn.prepareStatement(sql);

        int i = 1;
        if (tipoLocal != null && tipoLocal.trim().length() > 0) {
            ps.setString(i++, "%" + tipoLocal.trim() + "%");
        }
        if (capacidadeMin != null) {
            ps.setDouble(i++, capacidadeMin);
        }

        rs = ps.executeQuery();
%>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome do local</th>
        <th>Tipo</th>
        <th>Endereço</th>
        <th>Capacidade diária (kg)</th>
    </tr>
<%
    boolean tem = false;
    while (rs.next()) {
        tem = true;
%>
    <tr>
        <td><%= rs.getInt("id_destino") %></td>
        <td><%= rs.getString("nome_local") %></td>
        <td><%= rs.getString("tipo_local") %></td>
        <td><%= rs.getString("endereco") %></td>
        <td><%= rs.getDouble("capacidade_diaria") %></td>
    </tr>
<%
    }
%>
</table>

<%
    if (!tem) {
%>
    <p>Nenhum registro encontrado com os filtros informados.</p>
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

<p><a href="destinofinal_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Voltar</a></p>

</body>
</html>
