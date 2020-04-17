# Projeto para a disciplina "Programação para Dispositivos Moveis"

Back-end para a disciplina de "Programação para Dispositivos Moveis" da Unifacisa. Trata-se de um gerenciador de usuários, visitantes e beacons (Os beacons Bluetooth são transmissores de hardware - uma classe de dispositivos Bluetooth de baixa energia que transmitem seu identificador para dispositivos eletrônicos portáteis próximos)

# Pré-requisitos
	 Node.js
	 PostgreSQL

# Tecnologias

Back-end foi desenvolvido utilizando Node.js, express, nodemon, sequelize e postgreSQL. Para testar as requisições utilizei o Insomnia. E para validação dos dados uma biblioteca chamada Yup.

# Como executar o back-end

```
git clone https://github.com/arthuralveso/backend-museu.git
cd  backend-museu
yarn add express
yarn start
```

O servidor será executado em: [http://localhost:3000](http://localhost:3000)

# Mobile

O aplicativo mobile foi desenvolvido com Flutter, utilizando os conceitos da tecnologia, fizemos validação de formulario, realizamos as rotas entre as paginas do App, caputuramos o ID do celular e fazemos a conexão com o banco de dados.

# Pré-requisitos
  - Android Studio (SDK - system development kit)
  - Flutter (para instalação do flutter e demais requisitos, basta seguir a documentação no site oficial [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
  
 # Como executar o projeto mobile
  -A aplicaço pode ser executada num dipositivo fisico, através da entrada USB ou por um emulador que pode ser configurado pelo Android Studio
  -Com o dispositivo pronto basta executar:
  ```
  flutter run
  ```

