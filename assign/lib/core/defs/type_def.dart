// ignore_for_file: depend_on_referenced_packages

import 'package:assign/models/failure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef Futurevoid = FutureEither<void>;
