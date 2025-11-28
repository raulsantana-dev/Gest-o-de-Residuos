<%@page import="model.DAO.DestinoFinalDAO"%>
<%@page import="model.DestinoFinal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro - Destino Final</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String msg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nomeLocal = request.getParameter("nomeLocal");
        String tipoLocal = request.getParameter("tipoLocal");
        String endereco = request.getParameter("endereco");
        String capacidadeStr = request.getParameter("capacidadeDiaria");

        double capacidade = 0;
        if (capacidadeStr != null && capacidadeStr.trim().length() > 0) {
            try {
                capacidade = Double.parseDouble(capacidadeStr.replace(",", "."));
            } catch (NumberFormatException e) {
                msg = "Capacidade inválida.";
            }
        }

        if (msg == null) {
            try {
                DestinoFinal d = new DestinoFinal();
                d.setNomeLocal(nomeLocal);
                d.setTipoLocal(tipoLocal);
                d.setEndereco(endereco);
                d.setCapacidadeDiaria(capacidade);

                DestinoFinalDAO dao = new DestinoFinalDAO();
                boolean ok = dao.inserir(d);

                if (ok) {
                    msg = "Destino final cadastrado.";
                } else {
                    msg = "Não foi possível salvar.";
                }
            } catch (Exception e) {
                msg = "Erro: " + e.getMessage();
            }
        }
    }
%>

<h1>Cadastro - Destino Final</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form method="post">
    Nome do local: <input type="text" name="nomeLocal" required><br><br>
    Tipo de local: <input type="text" name="tipoLocal"><br><br>
    Endereço:<br>
    <textarea name="endereco" rows="3" cols="40"></textarea><br><br>
    Capacidade diária (kg): <input type="number" step="0.01" name="capacidadeDiaria"><br><br>

    <input type="submit" value="Salvar">
</form>

<p><a href="destinofinal_lista.jsp">Ver lista</a></p>
<p><a href="index.html">Voltar</a></p>

</body>
</html>
