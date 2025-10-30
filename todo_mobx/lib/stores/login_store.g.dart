// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_LoginStore.isFormValid'))
          .value;
  Computed<bool>? _$isVisibleComputed;

  @override
  bool get isVisible => (_$isVisibleComputed ??=
          Computed<bool>(() => super.isVisible, name: '_LoginStore.isVisible'))
      .value;
  Computed<bool>? _$liberaBotaoComputed;

  @override
  bool get liberaBotao =>
      (_$liberaBotaoComputed ??= Computed<bool>(() => super.liberaBotao,
              name: '_LoginStore.liberaBotao'))
          .value;
  Computed<VoidCallback?>? _$loginPressedComputed;

  @override
  VoidCallback? get loginPressed => (_$loginPressedComputed ??=
          Computed<VoidCallback?>(() => super.loginPressed,
              name: '_LoginStore.loginPressed'))
      .value;

  late final _$emailAtom = Atom(name: '_LoginStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$visivelAtom =
      Atom(name: '_LoginStore.visivel', context: context);

  @override
  bool get visivel {
    _$visivelAtom.reportRead();
    return super.visivel;
  }

  @override
  set visivel(bool value) {
    _$visivelAtom.reportWrite(value, super.visivel, () {
      super.visivel = value;
    });
  }

  late final _$carregandoAtom =
      Atom(name: '_LoginStore.carregando', context: context);

  @override
  bool get carregando {
    _$carregandoAtom.reportRead();
    return super.carregando;
  }

  @override
  set carregando(bool value) {
    _$carregandoAtom.reportWrite(value, super.carregando, () {
      super.carregando = value;
    });
  }

  late final _$loggedInAtom =
      Atom(name: '_LoginStore.loggedIn', context: context);

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginStore.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void setEmail(dynamic value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass(dynamic pass) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setPass');
    try {
      return super.setPass(pass);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisivel() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setVisivel');
    try {
      return super.setVisivel();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
visivel: ${visivel},
carregando: ${carregando},
loggedIn: ${loggedIn},
isFormValid: ${isFormValid},
isVisible: ${isVisible},
liberaBotao: ${liberaBotao},
loginPressed: ${loginPressed}
    ''';
  }
}
