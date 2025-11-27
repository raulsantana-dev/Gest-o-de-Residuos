<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Cadastro - Controle de Destino Final</title>
</head>
<body>
    <h1>Cadastro - Controle de Destino Final</h1>
    <form method="post">

        Nome do local: <input type="text" name="nomeLocal"><br>
        Tipo de local: <input type="text" name="tipoLocal"><br>
        Endereço: <input type="text" name="endereco"><br>
        Capacidade diária (kg): <input type="number" step="0.01" name="capacidadeDiaria"><br>

        <input type="submit" value="Salvar (protótipo)">
    </form>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
