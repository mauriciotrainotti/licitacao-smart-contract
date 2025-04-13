const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Testando ethers.utils.parseEther", function () {
  it("Deve converter uma string para wei corretamente", async function () {
    const valor = ethers.utils.parseEther("5"); // Converte 5 ETH para wei
    expect(valor).to.not.be.undefined; // Teste básico para garantir que a conversão funcionou
    console.log("Valor em wei:", valor.toString()); // Verifique o valor no console
  });
});
