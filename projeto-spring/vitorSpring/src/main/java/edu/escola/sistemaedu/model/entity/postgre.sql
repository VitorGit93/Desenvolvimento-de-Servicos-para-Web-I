CREATE SEQUENCE IF NOT EXISTS aluno_seq START WITH 1 INCREMENT BY 50;

CREATE TABLE aluno
(
    pessoaid                                                         UUID         NOT NULL,
    nome_completo                                                    VARCHAR(255),
    cpf                                                              VARCHAR(255),
    rg                                                               VARCHAR(255),
    data_nascimento                                                  TIMESTAMP WITHOUT TIME ZONE,
    genero                                                           VARCHAR(255),
    email                                                            VARCHAR(255),
    telefone_celular                                                 VARCHAR(255),
    telefone_fixo                                                    VARCHAR(255),
    endereco_id                                                      UUID,
    cidade_natal                                                     VARCHAR(255),
    estado_natal                                                     VARCHAR(255),
    estrangeiro                                                      BOOLEAN,
    dados_academicos_dado_academicoid                                UUID,
    dados_profissionais_col_dado_profissionalid_tb_dado_profissional UUID,
    alunoid                                                          BIGINT       NOT NULL,
    col_login_aluno                                                  VARCHAR(255),
    col_senha_aluno                                                  VARCHAR(255) NOT NULL,
    col_endereco_aluno                                               UUID,
    CONSTRAINT pk_aluno PRIMARY KEY (pessoaid, alunoid)
);

CREATE TABLE contrato
(
    contratoid        UUID NOT NULL,
    situacao_contrato VARCHAR(255),
    numero_contrato   INTEGER,
    tipo_contrato     VARCHAR(255),
    contratante       VARCHAR(255),
    modalidade        VARCHAR(255),
    data_inicio       date,
    data_termino      date,
    CONSTRAINT pk_contrato PRIMARY KEY (contratoid)
);

CREATE TABLE curso
(
    cursoid              INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    metodologia          VARCHAR(255),
    num_horas_aula_curso INTEGER                                  NOT NULL,
    duracao_curso        INTEGER                                  NOT NULL,
    descricao            VARCHAR(255),
    CONSTRAINT pk_curso PRIMARY KEY (cursoid)
);

CREATE TABLE matricula
(
    matriculaid           BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    atual                 BOOLEAN,
    metodologia           VARCHAR(255),
    data_inicio_matricula date,
    data_fim_matricula    date,
    num_horas_aula_curso  INTEGER,
    duracao_curso         INTEGER,
    dias_da_semana        VARCHAR(255),
    horario               VARCHAR(255),
    curso_cursoid         INTEGER,
    CONSTRAINT pk_matricula PRIMARY KEY (matriculaid)
);

CREATE TABLE matricula_professores
(
    matricula_matriculaid BIGINT NOT NULL,
    professores_pessoaid  UUID   NOT NULL
);

CREATE TABLE professor
(
    pessoaid                                                         UUID NOT NULL,
    nome_completo                                                    VARCHAR(255),
    cpf                                                              VARCHAR(255),
    rg                                                               VARCHAR(255),
    data_nascimento                                                  TIMESTAMP WITHOUT TIME ZONE,
    genero                                                           VARCHAR(255),
    email                                                            VARCHAR(255),
    telefone_celular                                                 VARCHAR(255),
    telefone_fixo                                                    VARCHAR(255),
    endereco_id                                                      UUID,
    cidade_natal                                                     VARCHAR(255),
    estado_natal                                                     VARCHAR(255),
    estrangeiro                                                      BOOLEAN,
    dados_academicos_dado_academicoid                                UUID,
    dados_profissionais_col_dado_profissionalid_tb_dado_profissional UUID,
    col_especialidade_tb_professor                                   VARCHAR(255),
    col_login_tb_professor                                           VARCHAR(255),
    col_senha_tb_professor                                           VARCHAR(255),
    CONSTRAINT pk_professor PRIMARY KEY (pessoaid)
);

CREATE TABLE tb_dado_academico
(
    dado_academicoid                         UUID NOT NULL,
    col_escolaridade_tb_dado_academico       VARCHAR(255),
    col_escolaridade_atual_tb_dado_academico VARCHAR(255),
    col_ano_conclusao_tb_dado_academico      VARCHAR(255),
    CONSTRAINT pk_tb_dadoacademico PRIMARY KEY (dado_academicoid)
);

CREATE TABLE tb_dado_profissional
(
    col_dado_profissionalid_tb_dado_profissional       UUID NOT NULL,
    col_profissao_funcao_cargo_tb_dado_profissional    VARCHAR(255),
    col_orgao_instituicao_empresa_tb_dado_profissional VARCHAR(255),
    col_outros_tb_dado_profissional                    VARCHAR(255),
    CONSTRAINT pk_tb_dadoprofissional PRIMARY KEY (col_dado_profissionalid_tb_dado_profissional)
);

CREATE TABLE tb_endereco
(
    id                          UUID NOT NULL,
    col_logradouro_tb_endereco  VARCHAR(255),
    col_complemento_tb_endereco VARCHAR(255),
    col_numero_tb_endereco      VARCHAR(255),
    col_bairro_tb_endereco      VARCHAR(255),
    col_cidade_tb_endereco      VARCHAR(255),
    col_estado_tb_endereco      VARCHAR(255),
    col_cep_tb_endereco         VARCHAR(255),
    CONSTRAINT pk_tb_endereco PRIMARY KEY (id)
);

ALTER TABLE aluno
    ADD CONSTRAINT uc_aluno_col_login_aluno UNIQUE (col_login_aluno);

ALTER TABLE aluno
    ADD CONSTRAINT uc_aluno_col_senha_aluno UNIQUE (col_senha_aluno);

ALTER TABLE aluno
    ADD CONSTRAINT uc_aluno_cpf UNIQUE (cpf);

ALTER TABLE aluno
    ADD CONSTRAINT uc_aluno_rg UNIQUE (rg);

ALTER TABLE professor
    ADD CONSTRAINT uc_professor_col_login_tb_professor UNIQUE (col_login_tb_professor);

ALTER TABLE professor
    ADD CONSTRAINT uc_professor_col_senha_tb_professor UNIQUE (col_senha_tb_professor);

ALTER TABLE professor
    ADD CONSTRAINT uc_professor_cpf UNIQUE (cpf);

ALTER TABLE professor
    ADD CONSTRAINT uc_professor_rg UNIQUE (rg);

ALTER TABLE aluno
    ADD CONSTRAINT FK_ALUNO_ON_COL_ENDERECO_ALUNO FOREIGN KEY (col_endereco_aluno) REFERENCES tb_endereco (id);

ALTER TABLE aluno
    ADD CONSTRAINT FK_ALUNO_ON_DADOSACADEMICOS_DADOACADEMICOID FOREIGN KEY (dados_academicos_dado_academicoid) REFERENCES tb_dado_academico (dado_academicoid);

ALTER TABLE aluno
    ADD CONSTRAINT FK_ALUNO_ON_DADOSPROFISSIONAISCOLDADOPROFISSIONALIDTBDADOPROFIS FOREIGN KEY (dados_profissionais_col_dado_profissionalid_tb_dado_profissional) REFERENCES tb_dado_profissional (col_dado_profissionalid_tb_dado_profissional);

ALTER TABLE aluno
    ADD CONSTRAINT FK_ALUNO_ON_ENDERECO FOREIGN KEY (endereco_id) REFERENCES tb_endereco (id);

ALTER TABLE matricula
    ADD CONSTRAINT FK_MATRICULA_ON_CURSO_CURSOID FOREIGN KEY (curso_cursoid) REFERENCES curso (cursoid);

ALTER TABLE professor
    ADD CONSTRAINT FK_PROFESSOR_ON_DADOSACADEMICOS_DADOACADEMICOID FOREIGN KEY (dados_academicos_dado_academicoid) REFERENCES tb_dado_academico (dado_academicoid);

ALTER TABLE professor
    ADD CONSTRAINT FK_PROFESSOR_ON_DADOSPROFISSIONAISCOLDADOPROFISSIONALIDTBDADOPR FOREIGN KEY (dados_profissionais_col_dado_profissionalid_tb_dado_profissional) REFERENCES tb_dado_profissional (col_dado_profissionalid_tb_dado_profissional);

ALTER TABLE professor
    ADD CONSTRAINT FK_PROFESSOR_ON_ENDERECO FOREIGN KEY (endereco_id) REFERENCES tb_endereco (id);

ALTER TABLE matricula_professores
    ADD CONSTRAINT fk_matpro_on_matricula FOREIGN KEY (matricula_matriculaid) REFERENCES matricula (matriculaid);

ALTER TABLE matricula_professores
    ADD CONSTRAINT fk_matpro_on_professor FOREIGN KEY (professores_pessoaid) REFERENCES professor (pessoaid);