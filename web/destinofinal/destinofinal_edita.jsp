<%@page import="model.DAO.DestinoFinalDAO"%>
<%@page import="model.DestinoFinal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edição - Destino Final</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    DestinoFinal destino = null;
    String msg = null;

    DestinoFinalDAO dao = null;
    try {
        dao = new DestinoFinalDAO();
    } catch (Exception e) {
        msg = "Erro ao abrir DAO: " + e.getMessage();
    }

    if (dao != null) {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String idStr = request.getParameter("id");
            String nomeLocal = request.getParameter("nomeLocal");
            String tipoLocal = request.getParameter("tipoLocal");
            String endereco = request.getParameter("endereco");
            String capacidadeStr = request.getParameter("capacidadeDiaria");

            try {
                int id = Integer.parseInt(idStr);
                double capacidade = 0;
                if (capacidadeStr != null && capacidadeStr.trim().length() > 0) {
                    capacidade = Double.parseDouble(capacidadeStr.replace(",", "."));
                }

                DestinoFinal d = new DestinoFinal();
                d.setIdDestino(id);
                d.setNomeLocal(nomeLocal);
                d.setTipoLocal(tipoLocal);
                d.setEndereco(endereco);
                d.setCapacidadeDiaria(capacidade);

                boolean ok = dao.atualizar(d);
                if (ok) {
                    msg = "Destino atualizado.";
                } else {
                    msg = "Não foi possível atualizar.";
                }
                destino = d;

            } catch (Exception e) {
                msg = "Erro: " + e.getMessage();
            }

        } else { // GET
            String idStr = request.getParameter("id");
            if (idStr != null && idStr.trim().length() > 0) {
                try {
                    int id = Integer.parseInt(idStr);
                    destino = dao.buscarPorId(id);
                    if (destino == null) {
                        msg = "Registro não encontrado.";
                    }
                } catch (Exception e) {
                    msg = "Erro: " + e.getMessage();
                }
            } else {
                msg = "ID não informado.";
            }
        }
    }

    String vId = (destino != null) ? String.valueOf(destino.getIdDestino()) : "";
    String vNome = (destino != null) ? destino.getNomeLocal() : "";
    String vTipo = (destino != null) ? destino.getTipoLocal() : "";
    String vEndereco = (destino != null) ? destino.getEndereco() : "";
    String vCapacidade = (destino != null) ? String.valueOf(destino.getCapacidadeDiaria()) : "";
%>

<h1>Edição - Destino Final</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form method="post">
    ID: <input type="number" name="id" value="<%= vId %>" readonly><br><br>
    Nome do local: <input type="text" name="nomeLocal" value="<%= vNome %>"><br><br>
    Tipo de local: <input type="text" name="tipoLocal" value="<%= vTipo %>"><br><br>
    Endereço:<br>
    <textarea name="endereco" rows="3" cols="40"><%= vEndereco %></textarea><br><br>
    Capacidade diária (kg): <input type="number" step="0.01" name="capacidadeDiaria" value="<%= vCapacidade %>"><br><br>

    <input type="submit" value="Salvar alterações">
</form>

<p><a href="destinofinal_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Voltar</a></p>

</body>
</html>
