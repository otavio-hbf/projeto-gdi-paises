CREATE TABLE MOEDA( 
    SIGLA_MOEDA VARCHAR(3) NOT NULL, 
    VALOR_EM_DOLAR FLOAT(6), 
    CONSTRAINT PK_MOEDA PRIMARY KEY (SIGLA_MOEDA) 
);

CREATE TABLE CRIPTOMOEDA( 
	SIGLA_MOEDA VARCHAR(3) NOT NULL, 
    BLOCKCHAIN VARCHAR(255), 
    CONSTRAINT PK_CRIPTOMOEDA PRIMARY KEY (SIGLA_MOEDA), 
    CONSTRAINT FK_MOEDA FOREIGN KEY (SIGLA_MOEDA) REFERENCES MOEDA (SIGLA_MOEDA) 
);

CREATE TABLE MOEDA_FIDUCIARIA(
    SIGLA_MOEDA VARCHAR(3) NOT NULL,
    CONSTRAINT PK_MOEDA_FIDUCIARIA PRIMARY KEY (SIGLA_MOEDA), 
    CONSTRAINT FK_MOEDAFID FOREIGN KEY (SIGLA_MOEDA) REFERENCES MOEDA (SIGLA_MOEDA)
);

CREATE TABLE PAIS(  
	SIGLA_PAIS VARCHAR(2) NOT NULL,
    NOME_PAIS VARCHAR(25) NOT NULL,
	PIB FLOAT(6),  
	EH_PENTA NUMBER(1) NOT NULL,  
	SIGLA_MOEDA VARCHAR(3),
	CONSTRAINT PK_PAIS PRIMARY KEY (SIGLA_PAIS), 
    CONSTRAINT FK_MOEDAPAIS FOREIGN KEY (SIGLA_MOEDA) REFERENCES MOEDA_FIDUCIARIA (SIGLA_MOEDA)
);

CREATE TABLE RECONHECE(
    RECONHECE VARCHAR(2) NOT NULL,
    RECONHECIDO VARCHAR(2) NOT NULL,
    CONSTRAINT PK_RECONHECE  PRIMARY KEY (RECONHECE, RECONHECIDO),
    CONSTRAINT FK_PAISRECONHECE FOREIGN KEY (RECONHECE) REFERENCES PAIS (SIGLA_PAIS),
    CONSTRAINT FK_PAISRECONHECIDO FOREIGN KEY (RECONHECIDO) REFERENCES PAIS (SIGLA_PAIS)  
);

CREATE TABLE CIDADE( 
    SIGLA_CIDADE VARCHAR(5) NOT NULL, 
    NOME_CIDADE VARCHAR(25)  NOT NULL,
    EH_CAPITAL NUMBER(1) NOT NULL, 
    SIGLA_PAIS VARCHAR(2) NOT NULL, 
    CONSTRAINT PK_CIDADE PRIMARY KEY (SIGLA_CIDADE), 
    CONSTRAINT FK_CIDADEPAIS FOREIGN KEY (SIGLA_PAIS) REFERENCES PAIS (SIGLA_PAIS) 
);

CREATE TABLE CORES_BANDEIRA( 
    COR VARCHAR(20) NOT NULL,
    SIGLA_PAIS VARCHAR(2) NOT NULL, 
    CONSTRAINT PK_COR_BANDEIRA PRIMARY KEY (COR, SIGLA_PAIS), 
    CONSTRAINT FK_BANDEIRA FOREIGN KEY (SIGLA_PAIS) REFERENCES PAIS (SIGLA_PAIS)
);

CREATE TABLE IDIOMA(
    SIGLA_IDIOMA VARCHAR(5) NOT NULL,
    NOME_IDIOMA VARCHAR(25) NOT NULL,
    NUMERO_FALANTES INTEGER,
    CONSTRAINT PK_IDIOMA PRIMARY KEY (SIGLA_IDIOMA)
);

CREATE TABLE OFICIAL(
    SIGLA_PAIS VARCHAR(2) NOT NULL,
    SIGLA_IDIOMA VARCHAR(3) NOT NULL,
    CONSTRAINT PK_OFICIAL PRIMARY KEY (SIGLA_PAIS, SIGLA_IDIOMA),
    CONSTRAINT FK_IDIOMAPAIS FOREIGN KEY (SIGLA_IDIOMA) REFERENCES IDIOMA (SIGLA_IDIOMA),
    CONSTRAINT FK_PAISIDIOMA FOREIGN KEY (SIGLA_PAIS) REFERENCES PAIS (SIGLA_PAIS)
);

CREATE TABLE OBRA_PUBLICA( 
    COD_OBRA VARCHAR(30) NOT NULL, 
    VALOR FLOAT(6) NOT NULL, 
    CONSTRAINT PK_OBRA_PUBLICA PRIMARY KEY (COD_OBRA) 
);

CREATE TABLE REALIZA( 
    COD_OBRA VARCHAR(30) NOT NULL,
    SIGLA_PAIS VARCHAR(2) NOT NULL, 
    CONSTRAINT PK_REALIZA PRIMARY KEY (COD_OBRA, SIGLA_PAIS), 
    CONSTRAINT FK_PAISREALIZA FOREIGN KEY (SIGLA_PAIS) REFERENCES PAIS (SIGLA_PAIS),
    CONSTRAINT FK_OBRAREALIZADA FOREIGN KEY (COD_OBRA) REFERENCES OBRA_PUBLICA (COD_OBRA)
);

CREATE TABLE EMPRESA_PRIVADA(
    NOME VARCHAR(25) NOT NULL,
    REGISTRO VARCHAR(25) NOT NULL, 
    RUA VARCHAR(25), 
    BAIRRO VARCHAR(25), 
    CIDADE VARCHAR(5), 
    CONSTRAINT PK_EMPRESA_PRIVADA PRIMARY KEY (REGISTRO), 
    CONSTRAINT PK_CIDADEEMPRESA FOREIGN KEY (CIDADE) REFERENCES CIDADE (SIGLA_CIDADE) 
);

CREATE TABLE PARCERIA(
    SIGLA_PAIS VARCHAR(2) NOT NULL,
    COD_OBRA VARCHAR(30) NOT NULL,
    REGISTRO VARCHAR(25) NOT NULL,
    CONSTRAINT PK_PARCERIA PRIMARY KEY (SIGLA_PAIS, COD_OBRA, REGISTRO),
    CONSTRAINT FK_REALIZAPARCERIA FOREIGN KEY (SIGLA_PAIS, COD_OBRA) REFERENCES REALIZA (SIGLA_PAIS, COD_OBRA),
    CONSTRAINT FK_EMPRESAPARCEIRA FOREIGN KEY (REGISTRO) REFERENCES EMPRESA_PRIVADA (REGISTRO)
);

CREATE TABLE COMMODITY(
    COD_SH VARCHAR(10) NOT NULL,
    COTACAO FLOAT(6) NOT NULL,
    TIPO VARCHAR(15) NOT NULL,
    CONSTRAINT PK_COMMODITY PRIMARY KEY (COD_SH)
);

CREATE TABLE COMPROU(
    COD_SH VARCHAR(10) NOT NULL,
    SIGLA_MOEDA VARCHAR(3) NOT NULL,
    SIGLA_PAIS VARCHAR(2) NOT NULL,
    DATA_COMPRA DATE NOT NULL,
    PRECO FLOAT(6) NOT NULL,
	CONSTRAINT PK_COMPROU PRIMARY KEY (COD_SH, SIGLA_MOEDA, SIGLA_PAIS, DATA_COMPRA),
    CONSTRAINT FK_COMMODITYCOMPRADA FOREIGN KEY (COD_SH) REFERENCES COMMODITY (COD_SH),
    CONSTRAINT FK_MOEDACOMPRA FOREIGN KEY (SIGLA_MOEDA) REFERENCES MOEDA (SIGLA_MOEDA),
    CONSTRAINT FK_PAISCOMPROU FOREIGN KEY (SIGLA_PAIS) REFERENCES PAIS (SIGLA_PAIS)
);
