import 'dart:convert';

class Project {
  final String title;
  final String madeWith;
  final String imageUrl;
  final String description;
  final String body;
  final String link;
  final String language;

  Project({
    required this.title,
    required this.madeWith,
    required this.imageUrl,
    required this.body,
    required this.description,
    required this.link,
    required this.language,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['Title'],
      madeWith: json['madeWith'],
      imageUrl: json['ImageUrl'],
      description: json['Excerpt'],
      body: json['Body'],
      link: json['link'],
      language: json['language'],
    );
  }

  static List<Project> get projects => Projects()._projects;
}

class Projects {
  List<Project> get _projects => loadJson();

  List<Project> loadJson() {
    String jsonStr = '''
    [
        {
                "Date Published": "2023-07-28",
                "Excerpt": "Just a simple game for fun",
                "Title": "RocketGame",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/simple-rocket.png",
                "Body": "Rocket Game",
                "link": "https://sharemygame.com/@adriel/rocketgame",
                "language": "en"
        },
        {
                "Date Published": "2019-12-15",
                "Excerpt": "It´s a dice game. Try your luck by arranging the different parameters of the game",
                "Title": "Dice-game",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/dice-game.png",
                "Body": "Game of dice. It´s possible to use various parameters in order to obtain different results and challenge the player luck to gain some bet. The original version had criptocurrency based bets",
                "link": "https://dice-game.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2023-07-30",
                "Excerpt": "Hit the targets",
                "Title": "ShootGame",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/shooter-game.png",
                "Body": "Just shoot the targets",
                "link": "https://sharemygame.com/@adriel/shoot-game",
                "language": "en"
        },
        {
                "Date Published": "2020-01-06",
                "Excerpt": "This is a very ancient tradition born in India five thousand years ago",
                "Title": "Krishna-said",
                "madeWith": "Vue.js and Three.js",
                "ImageUrl": "assets/images/krishna.png",
                "Body": "This website presents Krishna and the Bhagavad-gita",
                "link": "http://krishna-said-long-time-ago.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2023-08-14",
                "Excerpt": "Hit the planes",
                "Title": "AirBattle",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/air-battle-game.png",
                "Body": "Shoot the planes around the world",
                "link": "https://sharemygame.com/@adriel/air-battle",
                "language": "en"
        },
        {
                "Date Published": "2020-07-19",
                "Excerpt": "This website show some 2020 front-end challenges I took up using React.js. Hope you Enjoy it!",
                "Title": "Reactjs-front-end-challenges",
                "madeWith": "React.js",
                "ImageUrl": "assets/images/react-app.png",
                "Body": "Created with React.js",
                "link": "https://react-threejs-portfolio.web.app/",
                "language": "en"
        },
        {
                "Excerpt": "Essa aplicação permite o envio e recebimento de texto entre plataformas",
                "Title": "Multi-plataform-data-exchange",
                "madeWith": "Flutter",
                "ImageUrl": "assets/images/exchange.png",
                "Body": "Envio de texto entre plataformas (mobile-desktop)",
                "link": "https://login-anantadeva.herokuapp.com/",
                "language": "pt"
        },
        {
                "Date Published": "2020-01-07",
                "Excerpt": "Esssa é uma tradição muito antiga que nasceu na Índia há 5000 anos",
                "Title": "Krishna-disse",
                "madeWith": "Vue.js and Three.js",
                "ImageUrl": "assets/images/krishna.png",
                "Body": "Esse site apresenta Krishna e o Bhagavad-gita",
                "link": "http://krishna-disse.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2020-02-18",
                "Excerpt": "Front end enginnering challenges ever growing new types of solutions and ideas",
                "Title": "Front-end-challenges",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/frontend-challenges.png",
                "Body": "Many types of web development project challenges",
                "link": "https://front-end-challenges.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2019-12-15",
                "Excerpt": "É um jogo de dados. Tente sua sorte ajustando os diferentes parâmetros do jogo",
                "Title": "Dice-game",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/dice-game.png",
                "Body": "Jogo de dados. É possível usar vários parâmetros para obter resultados diferentes e desafiar a sorte do jogador para ganhar alguma aposta. A versão original tinha apostas baseadas em criptomoedas",
                "link": "https://dice-game.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2020-07-19",
                "Excerpt": "Esse site mostra alguns desafios front-end 2020 em usando React.js",
                "Title": "Reactjs-front-end-challenges",
                "madeWith": "React.js",
                "ImageUrl": "assets/images/react-app.png",
                "Body": "Feito usado React.js",
                "link": "https://react-threejs-portfolio.web.app/",
                "language": "pt"
        },
        {
                "Excerpt": "Atire nos alvos",
                "Title": "ShootGame",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/shooter-game.png",
                "Body": "Atire e acerte",
                "link": "https://sharemygame.com/@adriel/shoot-game",
                "language": "pt"
        },
        {
                "Date Published": "2023-08-14",
                "Excerpt": "Acerte os aviões",
                "Title": "AirBattle",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/air-battle-game.png",
                "Body": "Atire nos aviões",
                "link": "https://sharemygame.com/@adriel/air-battle",
                "language": "pt"
        },
        {
                "Date Published": "2019-10-16",
                "Excerpt": "Apenas o esqueleto de uma loja virtual que pode ser usada para vender livros, jóias etc.",
                "Title": "Haribol-store",
                "madeWith": "Vue.js and Laravel",
                "ImageUrl": "assets/images/haribol-store.png",
                "Body": "Protótipo para comércio virtual",
                "link": "https://haribol-store.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2019-09-03",
                "Excerpt": "Jogo da velha tradicional. Tente vencer a IA ou desligue-a caso não consiga",
                "Title": "Hash-game",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/tic-tac-toe.png",
                "Body": "Jogo da velha tradicional. Tente vencer a IA",
                "link": "https://adriel-hash-game.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2023-07-28",
                "Excerpt": "Simples jogo passatempo ",
                "Title": "RocketGame",
                "madeWith": "Unity",
                "ImageUrl": "assets/images/simple-rocket.png",
                "Body": "Rocket Game",
                "link": "https://sharemygame.com/@adriel/rocketgame",
                "language": "pt"
        },
        {
                "Date Published": "2019-10-16",
                "Excerpt": "It´s just a skeleton of a possible ecommerce website with products like books, jewels etc",
                "Title": "Haribol-store",
                "madeWith": "Vue.js and Laravel",
                "ImageUrl": "assets/images/haribol-store.png",
                "Body": "Ecommerce prototype",
                "link": "https://haribol-store.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2020-11-17",
                "Excerpt": "This application allows you to exchange data (text) between your plataforms",
                "Title": "Multi-plataform-data-exchange",
                "madeWith": "Flutter",
                "ImageUrl": "assets/images/exchange.png",
                "Body": "Send and receive (exchange) text between your plataforms (mobile / desktop)",
                "link": "https://login-anantadeva.herokuapp.com/",
                "language": "en"
        },
        {
                "Date Published": "2019-09-03",
                "Excerpt": "Traditional hash game. Try to beat the AI, or turn it off",
                "Title": "Hash-game",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/tic-tac-toe.png",
                "Body": "Traditional hash game. Try to beat the AI, or turn it off",
                "link": "https://adriel-hash-game.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2020-02-18",
                "Excerpt": "Desafios de desenvolvimento e engenharia de interface de usuário",
                "Title": "Front-end-challenges",
                "madeWith": "Vue.js",
                "ImageUrl": "assets/images/frontend-challenges.png",
                "Body": "Vários tipos de desafios de engenharia de interface de usuário",
                "link": "https://front-end-challenges.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2019-12-02",
                "Excerpt": "This app allow for attendants to talk between themselves and to outside clients",
                "Title": "Chat-solution",
                "madeWith": "Vanilla JS and Firebase",
                "ImageUrl": "assets/images/chat-clone.png",
                "Body": "This project was create in order to allow for attendants be registered in connection to a company and departament inside this company. The attendant / operator can talk to other operators and using a WhatsApp API to receive messages from clients talking to the company through the WhatsApp",
                "link": "https://chat-solution.web.app/",
                "language": "en"
        },
        {
                "Date Published": "2019-12-02",
                "Excerpt": "Esse app permite que atendentes conversem entre si e com clientes da empresa",
                "Title": "Chat-solution",
                "madeWith": "Vanilla JS and Firebase",
                "ImageUrl": "assets/images/chat-clone.png",
                "Body": "Este projeto foi criado para permitir que os atendentes sejam registrados em conexão com uma empresa e departamento dentro dessa empresa. O atendente / operador pode conversar com outros operadores e usar uma API do WhatsApp para receber mensagens de clientes que conversam com a empresa por meio do WhatsApp",
                "link": "https://chat-solution.web.app/",
                "language": "pt"
        },
        {
                "Date Published": "2023-11-18",
                "Excerpt": "This is built with React Three Fiber and React Spring. It´s a 3D portfolio",
                "Title": "React 3D Portfolio",
                "madeWith": "React Three Fiber",
                "ImageUrl": "assets/images/3d-port.png",
                "Body": "Since 2021 I started to learn React Three Fiber and React Spring. This is a 3D portfolio built with these technologies. If you click the black door you can play with the dummy or the bettle car",
                "link": "https://r3f-portfolio-three.vercel.app/",
                "language": "en"
        },
        {
                "Excerpt": "Isso é construído com React Three Fiber e React Spring. É um portfólio 3D",
                "Title": "React 3D Portfolio",
                "madeWith": "React Three Fiber",
                "ImageUrl": "assets/images/3d-port.png",
                "Body": "Desde 2021 comecei a aprender React Three Fiber e React Spring. Este é um portfólio 3D construído com essas tecnologias. Se você clicar na porta preta você pode brincar com o boneco ou com o carro bettle",
                "link": "https://r3f-portfolio-three.vercel.app/",
                "language": "pt"
        },
        {
                "Excerpt": "This is built with Vue and Three.js library for 3D effects on the web",
                "Title": "Vue 3D Portfolio",
                "madeWith": "Vue.js e Three.js",
                "ImageUrl": "assets/images/vue-port.png",
                "Body": "My first 3D portfolio. It was built with Vue.js and Three.js. It has some 3D effects demonstrating some examples of what is possible to do on the Web with modern technologies",
                "link": "https://adriel-portf.web.app/",
                "language": "en"
        },
        {
                "Excerpt": "Isso é construído com React Three Fiber e React Spring. É um portfólio 3D",
                "Title": "Vue 3D Portfolio",
                "madeWith": "Vue.js and Three.js",
                "ImageUrl": "assets/images/vue-port.png",
                "Body": "Meu primeiro portfólio 3D. Foi construído com Vue.js e Three.js. Tem alguns efeitos 3D demonstrando alguns exemplos do que é possível fazer na Web com tecnologias modernas",
                "link": "https://adriel-portf.web.app/",
                "language": "pt"
        }
]
  ''';
    List<Project> projects = parseProjects(jsonStr);

    return projects;
  }
}

List<Project> parseProjects(String jsonStr) {
  final List<dynamic> jsonList = json.decode(jsonStr);
  return jsonList.map((json) => Project.fromJson(json)).toList();
}
