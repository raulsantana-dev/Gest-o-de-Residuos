<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Cadastro - Inventário de Tipos de Resíduos</title>
</head>
<body>
    <h1>Cadastro - Inventário de Tipos de Resíduos</h1>
    <form method="post">

        Nome do material: <input type="text" name="nomeMaterial"><br>
        Código interno: <input type="text" name="codigoInterno"><br>
        Densidade (kg/m³): <input type="number" step="0.01" name="densidadeKgM3"><br>
        Valor venda estimado: <input type="number" step="0.01" name="valorVendaEstimado"><br>

        <input type="submit" value="Salvar (protótipo)">
    </form>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
