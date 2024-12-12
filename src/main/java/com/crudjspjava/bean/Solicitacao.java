package com.crudjspjava.bean;

import java.util.Date;

public class Solicitacao {
    private int id;
    private String nome;
    private String cpf;
    private double renda;
    private double pretensao;
    private int score;
    private double limiteCredito;
    private String cartao;
    private String validade;
    private String cvv;
    private String agencia;
    private String ocupacao;
    private String imovel;
    private String veiculo;
    private String outrosBens;
    private String numeroCartao; 
    private Date dataSolicitacao; 

   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAgencia() {
        return agencia;
    }

    public void setAgencia(String agencia) {
        this.agencia = agencia;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public double getRenda() {
        return renda;
    }

    public void setRenda(double renda) {
        this.renda = renda;
    }

    public double getPretensao() {
        return pretensao;
    }

    public void setPretensao(double pretensao) {
        this.pretensao = pretensao;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public double getLimiteCredito() {
        return limiteCredito;
    }

    public void setLimiteCredito(double limiteCredito) {
        this.limiteCredito = limiteCredito;
    }

    public String getCartao() {
        return cartao;
    }

    public void setCartao(String cartao) {
        this.cartao = cartao;
    }

    public String getValidade() {
        return validade;
    }

    public void setValidade(String validade) {
        this.validade = validade;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getOcupacao() {
        return ocupacao;
    }

    public void setOcupacao(String ocupacao) {
        this.ocupacao = ocupacao;
    }

    public String getImovel() {
        return imovel;
    }

    public void setImovel(String imovel) {
        this.imovel = imovel;
    }

    public String getVeiculo() {
        return veiculo;
    }

    public void setVeiculo(String veiculo) {
        this.veiculo = veiculo;
    }

    public String getOutrosBens() {
        return outrosBens;
    }

    public void setOutrosBens(String outrosBens) {
        this.outrosBens = outrosBens;
    }

    public String getNumeroCartao() { 
        return numeroCartao;
    }

    public void setNumeroCartao(String numeroCartao) { 
        this.numeroCartao = numeroCartao;
    }

    public Date getDataSolicitacao() { 
        return dataSolicitacao;
    }

    public void setDataSolicitacao(Date dataSolicitacao) { 
        this.dataSolicitacao = dataSolicitacao;
    }
}
