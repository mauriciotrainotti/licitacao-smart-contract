// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LicitacaoPublica {
    address public prefeitura;
    address public empresaVencedora;
    uint public valorObra;
    uint public prazoEntrega;
    bool public obraConcluida;
    bool public pagamentoEfetuado;

    struct Proposta {
        address empresa;
        uint valor;
    }

    Proposta[] public propostas;

    modifier apenasPrefeitura() {
        require(msg.sender == prefeitura, "Somente a prefeitura pode executar isso");
        _;
    }

    constructor(uint _prazoEntrega) {
        prefeitura = msg.sender;
        prazoEntrega = block.timestamp + _prazoEntrega;
    }

    function enviarProposta(uint _valor) public {
        require(block.timestamp < prazoEntrega, "Prazo de envio de propostas expirou");
        propostas.push(Proposta(msg.sender, _valor));
    }

    function escolherVencedora(uint index) public apenasPrefeitura {
        require(index < propostas.length, "Proposta invalida");
        empresaVencedora = propostas[index].empresa;
        valorObra = propostas[index].valor;
    }

    function registrarConclusaoObra() public apenasPrefeitura {
        obraConcluida = true;
    }

    function pagarEmpresa() public apenasPrefeitura {
        require(obraConcluida, "Obra nao concluida");
        require(!pagamentoEfetuado, "Pagamento ja efetuado");
        pagamentoEfetuado = true;
        payable(empresaVencedora).transfer(valorObra);
    }

    receive() external payable {}
}
