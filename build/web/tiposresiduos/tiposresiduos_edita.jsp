<%@page import="model.DAO.TipoResiduoDAO"%>
<%@page import="model.TipoResiduo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Edição - Inventário de Tipos de Resíduos</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";
    TipoResiduo tipo = null;
    TipoResiduoDAO dao = new TipoResiduoDAO();

    String metodo = request.getMethod();        
    String acao = request.getParameter("acao"); 
    try {
        if ("POST".equalsIgnoreCase(metodo)) {
            if ("carregar".equalsIgnoreCase(acao)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    tipo = dao.buscarPorId(id);
                    if (tipo == null) {
                        mensagem = "Tipo de resíduo não encontrado para o ID informado.";
                    }
                } else {
                    mensagem = "Informe um ID para carregar.";
                }
            } else if ("atualizar".equalsIgnoreCase(acao)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    String nomeMaterial = request.getParameter("nomeMaterial");
                    String codigoInterno = request.getParameter("codigoInterno");
                    String densidadeStr = request.getParameter("densidadeKgM3");
                    String valorStr = request.getParameter("valorVendaEstimado");
                    double densidade = 0;
                    double valorVenda = 0;
                    if (densidadeStr != null && !densidadeStr.isEmpty()) {
                        densidade = Double.parseDouble(densidadeStr);
                    }
                    if (valorStr != null && !valorStr.isEmpty()) {
                        valorVenda = Double.parseDouble(valorStr);
                    }
                    TipoResiduo tr = new TipoResiduo();
                    tr.setIdTipo(id);
                    tr.setNomeMaterial(nomeMaterial);
                    tr.setCodigoInterno(codigoInterno);
                    tr.setDensidadeKgM3(densidade);
                    tr.setValorVendaEstimado(valorVenda);
                    if (dao.atualizar(tr)) {
                        mensagem = "Registro atualizado com sucesso!";
                        tipo = tr;
                    } else {
                        mensagem = "Erro ao atualizar o registro. Verifique o ID.";
                    }
                } else {
                    mensagem = "ID é obrigatório para atualizar.";
                }
            }
        } else {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                tipo = dao.buscarPorId(id);
                if (tipo == null) {
                    mensagem = "Tipo de resíduo não encontrado para o ID informado.";
                }
            }
        }
    } catch (Exception e) {
        mensagem = "Erro: " + e.getMessage();
    }
    String vId = (tipo != null) ? String.valueOf(tipo.getIdTipo()) : "";
    String vNome = (tipo != null) ? tipo.getNomeMaterial() : "";
    String vCodigo = (tipo != null) ? tipo.getCodigoInterno() : "";
    String vDensidade = (tipo != null) ? String.valueOf(tipo.getDensidadeKgM3()) : "";
    String vValor = (tipo != null) ? String.valueOf(tipo.getValorVendaEstimado()) : "";
%>

    <h1>Edição - Inventário de Tipos de Resíduos</h1>

    <% if (mensagem != null && !mensagem.isEmpty()) { %>
        <p style="color:red;"><%= mensagem %></p>
    <% } %>

    <form method="post" action="tiposresiduos_edita.jsp">
        ID: <input type="number" name="id" value="<%= vId %>" required><br><br>

        Nome do material: <input type="text" name="nomeMaterial" value="<%= vNome %>"><br><br>
        Código interno: <input type="text" name="codigoInterno" value="<%= vCodigo %>"><br><br>
        Densidade (kg/m³): <input type="number" step="0.01" name="densidadeKgM3" value="<%= vDensidade %>"><br><br>
        Valor de venda estimado: <input type="number" step="0.01" name="valorVendaEstimado" value="<%= vValor %>"><br><br>

        <input type="submit" name="acao" value="carregar">
        <input type="submit" name="acao" value="atualizar">
    </form>

    <p><a href="tiposresiduos_lista.jsp">Voltar para lista</a></p>
    <p><a href="index.html">Voltar ao início</a></p>
</body>
</html>
