document.getElementById('credit-form').addEventListener('submit', function(event) {
    const nome = document.getElementById('nome').value;
    const cpf = document.getElementById('cpf').value;
    const renda = document.getElementById('renda').value;
    const ocupacao = document.getElementById('ocupacao').value;
    const pretensao = document.getElementById('pretensao').value;

    if (!(nome && cpf && renda && ocupacao && pretensao)) {
        event.preventDefault(); 
        alert("Por favor, preencha todos os campos.");
    }
});
