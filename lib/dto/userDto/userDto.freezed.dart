// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get first_login => throw _privateConstructorUsedError;
  String? get last_login => throw _privateConstructorUsedError;
  String? get avatar_url => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get behaviour => throw _privateConstructorUsedError;
  bool get is_active => throw _privateConstructorUsedError;
  bool get has_verified_email => throw _privateConstructorUsedError;
  bool get is_history_private => throw _privateConstructorUsedError;
  bool get is_profile_private => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String username,
      String? first_login,
      String? last_login,
      String? avatar_url,
      String role,
      String? behaviour,
      bool is_active,
      bool has_verified_email,
      bool is_history_private,
      bool is_profile_private});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? first_login = freezed,
    Object? last_login = freezed,
    Object? avatar_url = freezed,
    Object? role = null,
    Object? behaviour = freezed,
    Object? is_active = null,
    Object? has_verified_email = null,
    Object? is_history_private = null,
    Object? is_profile_private = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      first_login: freezed == first_login
          ? _value.first_login
          : first_login // ignore: cast_nullable_to_non_nullable
              as String?,
      last_login: freezed == last_login
          ? _value.last_login
          : last_login // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      behaviour: freezed == behaviour
          ? _value.behaviour
          : behaviour // ignore: cast_nullable_to_non_nullable
              as String?,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
      has_verified_email: null == has_verified_email
          ? _value.has_verified_email
          : has_verified_email // ignore: cast_nullable_to_non_nullable
              as bool,
      is_history_private: null == is_history_private
          ? _value.is_history_private
          : is_history_private // ignore: cast_nullable_to_non_nullable
              as bool,
      is_profile_private: null == is_profile_private
          ? _value.is_profile_private
          : is_profile_private // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String username,
      String? first_login,
      String? last_login,
      String? avatar_url,
      String role,
      String? behaviour,
      bool is_active,
      bool has_verified_email,
      bool is_history_private,
      bool is_profile_private});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? first_login = freezed,
    Object? last_login = freezed,
    Object? avatar_url = freezed,
    Object? role = null,
    Object? behaviour = freezed,
    Object? is_active = null,
    Object? has_verified_email = null,
    Object? is_history_private = null,
    Object? is_profile_private = null,
  }) {
    return _then(_$_User(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      first_login: freezed == first_login
          ? _value.first_login
          : first_login // ignore: cast_nullable_to_non_nullable
              as String?,
      last_login: freezed == last_login
          ? _value.last_login
          : last_login // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      behaviour: freezed == behaviour
          ? _value.behaviour
          : behaviour // ignore: cast_nullable_to_non_nullable
              as String?,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
      has_verified_email: null == has_verified_email
          ? _value.has_verified_email
          : has_verified_email // ignore: cast_nullable_to_non_nullable
              as bool,
      is_history_private: null == is_history_private
          ? _value.is_history_private
          : is_history_private // ignore: cast_nullable_to_non_nullable
              as bool,
      is_profile_private: null == is_profile_private
          ? _value.is_profile_private
          : is_profile_private // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(
      {required this.id,
      required this.username,
      required this.first_login,
      required this.last_login,
      required this.avatar_url,
      required this.role,
      required this.behaviour,
      required this.is_active,
      required this.has_verified_email,
      required this.is_history_private,
      required this.is_profile_private});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  final String? first_login;
  @override
  final String? last_login;
  @override
  final String? avatar_url;
  @override
  final String role;
  @override
  final String? behaviour;
  @override
  final bool is_active;
  @override
  final bool has_verified_email;
  @override
  final bool is_history_private;
  @override
  final bool is_profile_private;

  @override
  String toString() {
    return 'User(id: $id, username: $username, first_login: $first_login, last_login: $last_login, avatar_url: $avatar_url, role: $role, behaviour: $behaviour, is_active: $is_active, has_verified_email: $has_verified_email, is_history_private: $is_history_private, is_profile_private: $is_profile_private)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.first_login, first_login) ||
                other.first_login == first_login) &&
            (identical(other.last_login, last_login) ||
                other.last_login == last_login) &&
            (identical(other.avatar_url, avatar_url) ||
                other.avatar_url == avatar_url) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.behaviour, behaviour) ||
                other.behaviour == behaviour) &&
            (identical(other.is_active, is_active) ||
                other.is_active == is_active) &&
            (identical(other.has_verified_email, has_verified_email) ||
                other.has_verified_email == has_verified_email) &&
            (identical(other.is_history_private, is_history_private) ||
                other.is_history_private == is_history_private) &&
            (identical(other.is_profile_private, is_profile_private) ||
                other.is_profile_private == is_profile_private));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      first_login,
      last_login,
      avatar_url,
      role,
      behaviour,
      is_active,
      has_verified_email,
      is_history_private,
      is_profile_private);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String username,
      required final String? first_login,
      required final String? last_login,
      required final String? avatar_url,
      required final String role,
      required final String? behaviour,
      required final bool is_active,
      required final bool has_verified_email,
      required final bool is_history_private,
      required final bool is_profile_private}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  String? get first_login;
  @override
  String? get last_login;
  @override
  String? get avatar_url;
  @override
  String get role;
  @override
  String? get behaviour;
  @override
  bool get is_active;
  @override
  bool get has_verified_email;
  @override
  bool get is_history_private;
  @override
  bool get is_profile_private;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
