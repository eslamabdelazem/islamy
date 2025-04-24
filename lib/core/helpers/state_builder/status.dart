enum Status{
  initial,
  loading,
  success,
  error
}

extension StatusBuilderHelper on Status{
  T when<T>({
    T Function()? onInitial,
    required T Function() onSuccess,
    required T Function() onError
}){
    switch(this){
      case Status.initial:
        return onInitial?.call() ?? onSuccess();

      case Status.success:
      case Status.loading:
        return onSuccess();

      case Status.error:
        return onError();
    }
  }
}