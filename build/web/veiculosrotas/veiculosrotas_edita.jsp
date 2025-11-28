<%@page import="model.DAO.VeiculoRotaDAO"%>
<%@page import="model.VeiculoRota"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Veículo / Rota</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    VeiculoRota veiculo = null;
    String msg = null;

    VeiculoRotaDAO dao = null;
    try {
        dao = new VeiculoRotaDAO();
    } catch (Exception e) {
        msg = "Erro ao abrir DAO: " + e.getMessage();
    }

    if (dao != null) {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String idStr = request.getParameter("id");
            String placa = request.getParameter("placa");
            String cap = request.getParameter("capacidadeM3");
            String rotaNome = request.getParameter("rotaNome");
            String rotaDesc = request.getParameter("rotaDescricao");
            String dia = request.getParameter("diaSemanaRota");

            try {
                int id = Integer.parseInt(idStr);
                double capacidade = 0;

                if (cap != null && cap.trim().length() > 0) {
                    capacidade = Double.parseDouble(cap.replace(",", "."));
                }

                VeiculoRota v = new VeiculoRota();
                v.setIdVeiculo(id);
                v.setPlaca(placa);
                v.setCapacidadeM3(capacidade);
                v.setRotaNome(rotaNome);
                v.setRotaDescricao(rotaDesc);
                v.setDiaSemanaRota(dia);

                boolean ok = dao.atualizar(v);
                if (ok) {
                    msg = "Atualizado.";
                } else {
                    msg = "Não foi possível atualizar.";
                }
                veiculo = v;
            } catch (Exception e) {
                msg = "Erro: " + e.getMessage();
            }

        } else { // GET
            String idStr = request.getParameter("id");
            if (idStr != null && idStr.trim().length() > 0) {
                try {
                    int id = Integer.parseInt(idStr);
                    veiculo = dao.buscarPorId(id);
                    if (veiculo == null) {
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

    String vId = (veiculo != null) ? String.valueOf(veiculo.getIdVeiculo()) : "";
    String vPlaca = (veiculo != null) ? veiculo.getPlaca() : "";
    String vCap = (veiculo != null) ? String.valueOf(veiculo.getCapacidadeM3()) : "";
    String vRota = (veiculo != null) ? veiculo.getRotaNome() : "";
    String vDesc = (veiculo != null) ? veiculo.getRotaDescricao() : "";
    String vDia = (veiculo != null) ? veiculo.getDiaSemanaRota() : "";
%>

<h1>Editar Veículo / Rota</h1>

<% if (msg != null) { %>
    <p><%= msg %></p>
<% } %>

<form method="post">
    ID: <input type="number" name="id" value="<%= vId %>" readonly><br><br>
    Placa: <input type="text" name="placa" value="<%= vPlaca %>"><br><br>
    Capacidade (m³): <input type="number" step="0.01" name="capacidadeM3" value="<%= vCap %>"><br><br>
    Nome da rota: <input type="text" name="rotaNome" value="<%= vRota %>"><br><br>
    Descrição da rota: <input type="text" name="rotaDescricao" value="<%= vDesc %>"><br><br>
    Dia da semana: <input type="text" name="diaSemanaRota" value="<%= vDia %>"><br><br>

    <input type="submit" value="Salvar alterações">
</form>

<p><a href="veiculosrotas_lista.jsp">Voltar para lista</a></p>
<p><a href="index.html">Início</a></p>

</body>
</html>
