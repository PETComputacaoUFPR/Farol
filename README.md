# Projeto Farol em Ruby on Rails

Esta é a versão 4 do projeto Farol, a.k.a. "agoravai"!

Abaixo estão algumas instruções de como instalar o projeto e tudo mais. Boa sorte!

## Instalando o projeto

Se é sua primeira vez utilizando ruby, ruby on rails ou instalando este projeto, considere seguir os passos a seguir:

1 Adicione o repositório contendo as versões mais recentes do Ruby:

```bash
$ sudo add-apt-repository ppa:brightbox/ruby-ng
$ sudo apt update
```

2 Certifique-se de que você tem os seguintes pacotes instalados:

```bash
$ sudo apt install rails ruby gcc build-essential patch ruby-dev ruby2.0-dev ruby2.2-dev ruby2.3-dev zlib1g-dev liblzma-dev libsqlite3-dev libmagick++-dev
$ sudo gem install rmagick -v '2.13.4'
```

3 Clone o repositório e instale as dependências:

```bash
$ git clone https://SEU_USUARIO@gitlab.com/PET-Computacao-UFPR/farolRails.git
$ cd farolRails/
$ bundle install
$ rails db:setup
$ rails db:migrate
```

4 Teste seu servidor. Para isso, rode o comando abaixo e abra seu navegador no IP de Loopback [127.0.0.1:3000/](127.0.0.1:3000/):

```bash
$ rails s
```

Seja bem-vindo ao projeto!
