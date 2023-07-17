import 'package:equatable/equatable.dart';

/// The base class for the Params of all use cases
abstract class BaseParams extends Equatable {}

/// The default class for empty params of use cases
class NoParams extends BaseParams {
  NoParams._privateConstructor();

  static final NoParams _instance = NoParams._privateConstructor();

  /// The default class for empty params of use cases
  factory NoParams() => _instance;

  @override
  List<Object?> get props => [];
}