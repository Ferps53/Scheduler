# Scheduler

## Instalação

> #### Antes de instalar o projeto no celular deve ser rodado os comandos:
> - dart run flutter_native_splash:create
> - flutter pub run flutter_launcher_icons  
> O primeiro para a criação da tela de splash.  
> O segundo para criar os ícones

## Padrão do projeto

### MVVM

Este projeto usa o padrão **MVVM**, que em suas partes é model, viewmodel, e view,
sendo que cada uma dessas camadas tem sua responsabilidade única.
Link para a documentação desse modelo [MVVM Docs](https://medium.com/@rafaellevissa/simplificando-o-desenvolvimento-de-aplicativos-com-o-flutter-em-arquitetura-mvvm-f4727bedff16)

Mais especifícamente esse projeto tem a ideia de trabalhar com duas pastas principais na lib
a Core a Features.

- Core é a pasta onde todos as funcionalidades e widgets mais genéricos e 
que podem ser utilizados em outras partes do sistema ficam.
- Features é a pasta onde se encontram as funcionalidades especificas de módulos da aplicação
um exemplo disso é a autenticação

### Estrutura de pastas

~~~
lib
|_core
|    |_Dio --> Pacote de http e interceptores
|    |_Environments --> Variavéis de ambiente
|    |_Presentation --> Widgets e páginas genéricas
|    |_Router --> Roteamento
|
|_features
    |_auth
        |_data----------> Model
        |    |_datasources
        |    |_model
        |    |_repo
        |_domain--------> ViewModel
        |    |_entities
        |    |_repo
        |    |_usecase
        |_view----------> View
             |_pages
             |_providers
             |_widgets
~~~

> ### Data
> A camada data é responsavel por prover os dados utilizados pelo app, seria a model.  
> **Datasource** é onde ficam as classes que se comunicam com Api's externas e bancos de dados locais
> **Model** é o modelo que será utilizado pela datasource  
> **Repo** é a camada de conversão entre as models utilizada pela datasource para entities que serão trafegadas pela aplicação e também é onde são aplicadas as regras de negócio   
>> A repo na camada Data é a implementação da Repo da Domain  

Todos os códigos de exemplo abaixo podem ser encontrados seguindo a estrutura de arquivos do projeto

Exemplo de Datasource
~~~dart
class JwtDatasourceImpl implements JwtDatasource {

//Aqui é utilizada a injeção de dependências para poder facilitar a escrita de testes para o código
  final Store _store;
  final Dio _dio;

  JwtDatasourceImpl({required Store store, required Dio dio})
      : _store = store,
        _dio = dio;

  //Chamada de Api para fazer o login
  @override
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin) async {
    try {
      final response = await _dio.post("${Environments.backendRoot}/auth/login",
          data: dadosLogin.toJson());
      final jwtModel = JwtModel.fromJson(response.data);
      saveJwt(jwtModel, 'token');
      return jwtModel;
    } catch (e) {
      rethrow;
    }
  }

  //Recupera um token salvo no armazenamento do dispositivo
  @override
  JwtModel? getJwtFromLocalStorage(String key) {
    final jsonStored = _store.getMap(key);
    if (jsonStored.isNotEmpty) {
      final jwt = JwtModel.fromJson(_store.getMap(key));
      return jwt;
    } else {
      return null;
    }
  }

 //Remove o token do armazenamento
  @override
  void removeJwt() {
    _store.remove('token');
  }

  //Salva o token no armazenamento interno
  @override
  Future<void> saveJwt(JwtModel jwt, String key) async {
    await _store.saveMap(key, jwt.toJson());
  }
}
~~~

Exemplo de Model
~~~dart
//Onde o código gerado pelo freezed é arquivado
part 'jwt_model.g.dart';
part 'jwt_model.freezed.dart';

//Aqui é utilizado a package Freezed para facilitar a criação de classes imutáveis
@freezed
class JwtModel with _$JwtModel {
  factory JwtModel({
    required String access_token,
    required String? refresh_token,
  }) = _JwtModel;

  factory JwtModel.fromJson(Map<String, Object?> json) =>
      _$JwtModelFromJson(json);
}
~~~

Exemplo de Repo na Data
~~~dart
class LoginRepoImpl implements LoginRepo {
  //Aqui é enfatizado que a repo depende da datasource
  final JwtDatasource _jwtDatasource;

  LoginRepoImpl({required JwtDatasource jwtDatasource})
      : _jwtDatasource = jwtDatasource;

  //StatusLogin é o enum utilizado pelos providers para validar o status do login
  @override
  StatusLogin autoLogin() {
    JwtModel? jwtModel = _jwtDatasource.getJwtFromLocalStorage('token');
    return _jwtToStatus(jwtModel);
  }

  @override
  void deslogar() {
    _jwtDatasource.removeJwt();
  }

  @override
  Future<StatusLogin> login(DadosLogin dadosLogin) async {
    final JwtModel jwtModel = await _jwtDatasource.fetchJwt(dadosLogin);
    return _jwtToStatus(jwtModel);
  }

  StatusLogin _jwtToStatus(JwtModel? jwtModel) {
    if (jwtModel != null) {
      final Map<String, dynamic> tokenPayload =
          JwtDecoder.decode(jwtModel.access_token);
      if (tokenPayload.isNotEmpty) {
        return StatusLogin.logado;
      }
    }
    return StatusLogin.deslogado;
  }
}
~~~

> ### Domain   
> A Domain é a camada onde é trabalhada a regra de negócio da aplicação e onde os dados são trasnferidos para a view  
> **Repo** nessa camada é uma interface para ser implementado na data.  
> **Entities** é a estrutura de dados que será trafegada pelas telas.  
> **Use case** são os casos de uso, ou seja, as funcionalidades chamadas pelas telas.  

Exemplo de Repo na Domain
~~~dart
abstract class LoginRepo {
  Future<StatusLogin> login(DadosLogin dadosLogin);

  StatusLogin autoLogin();

  void deslogar();
}
~~~

Exemplo de Entities
~~~dart

part 'dados_login.g.dart';
part 'dados_login.freezed.dart';

@freezed
class DadosLogin with _$DadosLogin {
  const factory DadosLogin({
    required String nomeUsuario,
    required String email,
    required String senha,
  }) = _DadosLogin;

  factory DadosLogin.fromJson(Map<String, dynamic> json) =>
      _$DadosLoginFromJson(json);
}

enum StatusLogin {
  logado,
  deslogado,
}
~~~

Exemplo de Use Case
~~~dart 

//Dessa forma chamando Login(dadosLogin: dadosLogin)(); executa a função call;
class Login {
  final LoginRepo loginRepo;

  Login(required LoginRepo loginRepo);

  Future<StatusLogin> call(DadosLogin dadosLogin) async {
    return await loginRepo.login(dadosLogin);
  }
}

~~~

> ### View
> A view é a camada que renderiza os widgets na tela e onde utilizamos o flutter.  
> **Pages** são as páginas da aplicação.  
> **Providers** são os módulos de injeção de dependência para poder assistir a alterações de estado das outras camadas do app  
> **Widgets** são os componentes que constroem a aplicação

Exemplo de Page  
~~~dart
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        children: [
          Background(),
          LoginForm(),
        ],
      ),
    );
  }
}

~~~
Exemplo de Provider utilizado pela tela 
~~~dart
final loginAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<LoginAsyncNotifier, StatusLogin>(() {
  return LoginAsyncNotifier();
});

class LoginAsyncNotifier extends AutoDisposeAsyncNotifier<StatusLogin> {
  @override
  Future<StatusLogin> build() async {
    final loginRepo = await ref.read(loginRepoProvider);
    return loginRepo.autoLogin();
  }

  void login(DadosLogin dadosLogin, BuildContext context) async {
    state = const AsyncLoading();
    final loginRepo = await ref.read(loginRepoProvider);
    state = await AsyncValue.guard(
      () async => await loginRepo.login(dadosLogin),
    );
    if (state.value == StatusLogin.logado) {
      if (context.mounted) {
        context.goNamed(NamedRoutes.tarefas.routeName);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Falha no login")));
      }
    }
  }
}
~~~

Exemplo de Provider para injeção de dependência
~~~dart 

final jwtDatasourceProvider = Provider((ref) async {
  final dio = ref.read(dioProvider);
  final store = ref.read(storeProvider);
  return JwtDatasourceImpl(store: await store, dio: dio);
});

final loginRepoProvider = Provider((ref) async {
  final JwtDatasource jwtDatasource = await ref.read(jwtDatasourceProvider);
  return LoginRepoImpl(jwtDatasource: jwtDatasource);
});
~~~

Exemplo de Widget  
~~~dart
class GlassTextLoadingButton extends StatelessWidget {
  final AppColors colors;

  const GlassTextLoadingButton({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: colors.backgroundColor.withOpacity(0.25),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
      onPressed: null,
      child: Center(
        child: Transform.scale(
          scale: 0.8,
          child: LoadingAnimationWidget.waveDots(
              color: colors.textColor, size: 32),
        ),
      ),
    );
  }
}
~~~
