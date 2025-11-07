// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupMobx on _SignupMobx, Store {
  late final _$nomeAtom = Atom(name: '_SignupMobx.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$celularAtom =
      Atom(name: '_SignupMobx.celular', context: context);

  @override
  String get celular {
    _$celularAtom.reportRead();
    return super.celular;
  }

  @override
  set celular(String value) {
    _$celularAtom.reportWrite(value, super.celular, () {
      super.celular = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_SignupMobx.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userPassAtom =
      Atom(name: '_SignupMobx.userPass', context: context);

  @override
  String get userPass {
    _$userPassAtom.reportRead();
    return super.userPass;
  }

  @override
  set userPass(String value) {
    _$userPassAtom.reportWrite(value, super.userPass, () {
      super.userPass = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_SignupMobx.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$createUserAsyncAction =
      AsyncAction('_SignupMobx.createUser', context: context);

  @override
  Future<bool?> createUser(String nm, String cel, String userE, String userP) {
    return _$createUserAsyncAction
        .run(() => super.createUser(nm, cel, userE, userP));
  }

  @override
  String toString() {
    return '''
nome: ${nome},
celular: ${celular},
userEmail: ${userEmail},
userPass: ${userPass},
loading: ${loading}
    ''';
  }
}
