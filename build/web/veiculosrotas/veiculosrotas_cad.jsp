<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <meta charset="UTF-8">
    <title>Cadastro - Registro de Veículos e Rotas</title>
</head>
<body>
    <h1>Cadastro - Registro de Veículos e Rotas</h1>
    <form method="post">

        Placa: <input type="text" name="placa"><br>
        Capacidade (m³): <input type="number" step="0.01" name="capacidadeM3"><br>
        Nome da rota: <input type="text" name="rotaNome"><br>
        Descrição da rota: <input type="text" name="rotaDescricao"><br>
        Dia da semana: <input type="text" name="diaSemanaRota"><br>

        <input type="submit" value="Salvar (protótipo)">
    </form>
    <p><a href="index.html">Voltar</a></p>
</body>
</html>
