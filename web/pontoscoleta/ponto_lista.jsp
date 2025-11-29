<%@page import="java.util.List"%>
<%@page import="model.PontoColeta"%>
<%@page import="model.DAO.PontoColetaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Pontos de Coleta</title>

    <!-- CSS GLOBAL -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="layout-lista">

    <!-- CONTEÚDO PRINCIPAL -->
    <main class="main-content">

        <h1>Lista de Pontos de Coleta</h1>
        <p class="subtitle">Todos os pontos cadastrados no sistema</p>

        <div class="table-container">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Endereço</th>
                    <th>Capacidade (kg)</th>
                    <th>Status</th>
                    <th>Freq. Coleta (dias)</th>
                </tr>

                <%
                    try {
                        PontoColetaDAO dao = new PontoColetaDAO();
                        List<PontoColeta> lista = dao.listarTodos();

                        if (lista != null && !lista.isEmpty()) {
                            for (PontoColeta pc : lista) {
                %>
                <tr>
                    <td><%= pc.getId() %></td>
                    <td><%= pc.getNomePonto() %></td>
                    <td><%= pc.getEndereco() %></td>
                    <td><%= pc.getCapacidadeKg() %></td>
                    <td><%= pc.getStatus() %></td>
                    <td><%= pc.getFrequenciaColetaDias() %></td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr>
                    <td colspan="6" style="text-align:center; padding:20px;">
                        Nenhum ponto de coleta encontrado.
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                <tr>
                    <td colspan="6" style="color:#ff6b6b; padding:20px;">
                        Erro: <%= e.getMessage() %>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>

        <p style="margin-top:20px;">
            <a class="voltar" href="index-coleta.html">Voltar</a>
        </p>

    </main>

</div>

</body>
</html>
